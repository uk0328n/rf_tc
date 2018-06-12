class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @customers = Customer.all
    @advisors = Advisor.all
    @activities = Activity.where(event_id: params[:id]).joins(:customer).includes(:customer).order('customers.kana COLLATE "ja_JP.utf8" ASC')
    @event_details = EventDetail.where(event_id: params[:id]).joins(:advisor).includes(:advisor).order('advisors.kana COLLATE "ja_JP.utf8" ASC')
    @number_of_participants = @activities.where(attendance_type: 1).count + @event_details.where(attendance_type: 1).count
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string(template: "events/show.csv.ruby"), filename: "event_#{@event.name}_#{@event.event_date.strftime("%Y%m%d")}_#{@event.venue}.csv", type: :csv
      end
    end
  end

  # GET /events/new
  def new
    @event = Event.new
    Customer.all.each do |c|
      @event.activities.build(customer_id: c.id, attendance_type: 2)
    end
    Advisor.all.each do |a|
      @event.event_details.build(advisor_id: a.id, attendance_type: 2)
    end
  end

  # GET /events/1/edit
  def edit
    Customer.all.each do |c|
      if Activity.where(event_id: @event.id, customer_id: c.id).blank?
        @event.activities.build(event_id: @event.id, customer_id: c.id, attendance_type: 2)
      end
    end
    Advisor.all.each do |a|
      if EventDetail.where(event_id: @event.id, advisor_id: a.id).blank?
        @event.event_details.build(event_id: @event.id, advisor_id: a.id, attendance_type: 2)
      end
    end
    @event.activities.joins(:customer).includes(:customer).order('customer.kana COLLATE "ja_JP.utf8" ASC')
    @event.event_details.joins(:advisor).includes(:advisor).order('advisor.kana COLLATE "ja_JP.utf8" ASC')
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        logger.debug @event.errors.inspect
        format.html { redirect_to @event, notice: 'データが新規作成されました。' }
        format.json { render :show, status: :created, location: @event }
      else
        logger.debug @event.errors.to_hash(true)
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      # @event.activities.each do |ac|
        # if ac.id.blank?
          # unless ac.save
            # logger.debug ac.errors.to_hash(true)
            # format.html { redirect_to :action => 'new' }
            # format.json { render json: @event.errors, status: :unprocessable_entity }
          # end
        # end
      # end
      begin
        if @event.update(update_event_params)
          format.html { redirect_to @event, notice: 'データが更新されました。' }
          format.json { render :show, status: :ok, location: @event }
        else
          format.html { render :edit }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      rescue ActiveRecord::RecordNotUnique => exception
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'データが削除されました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(Event.column_names.map{|c| c.to_sym} - ['id', 'created_at', 'updated_at'], {activities_attributes: [:event_id, :customer_id, :attendance_type, :editor_code]}, {event_details_attributes: [:event_id, :advisor_id, :attendance_type, :editor_code]})
    end

    def update_event_params
      params.require(:event).permit(Event.column_names.map{|c| c.to_sym} - ['created_at', 'updated_at'], {activities_attributes: [:id, :event_id, :customer_id, :attendance_type, :editor_code]}, {event_details_attributes: [:id, :event_id, :advisor_id, :attendance_type, :editor_code]})
    end
end
