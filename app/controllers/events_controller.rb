class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :fix]
  before_action :authenticate_admin!

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @customers = Person.where(role_type: 1)
    @advisors = Person.where(role_type: 2)
    @number_of_participants = Activity.where(event_id: params[:id], attendance_type: 1).count
    case params[:q]
    when 'presentee'
      @customer_activities = Activity.includes(:person).where(event_id: params[:id], attendance_type: 1).where('people.role_type = 1')
      @advisor_activities = Activity.includes(:person).where(event_id: params[:id], attendance_type: 1).where('people.role_type = 2')
      @fixed_customer_activities = Activity.where(event_id: params[:id], attendance_type: 1).where(fixed_role_type: 1)
      @fixed_advisor_activities = Activity.where(event_id: params[:id], attendance_type: 1).where(fixed_role_type: 2)
    when 'absentee'
      @customer_activities = Activity.includes(:person).where(event_id: params[:id], attendance_type: 2).where('people.role_type = 1')
      @advisor_activities = Activity.includes(:person).where(event_id: params[:id], attendance_type: 2).where('people.role_type = 2')
      @fixed_customer_activities = Activity.where(event_id: params[:id], attendance_type: 2).where(fixed_role_type: 1)
      @fixed_advisor_activities = Activity.where(event_id: params[:id], attendance_type: 2).where(fixed_role_type: 2)
    else
      @customer_activities = Activity.includes(:person).where(event_id: params[:id]).where('people.role_type = 1')
      @advisor_activities = Activity.includes(:person).where(event_id: params[:id]).where('people.role_type = 2')
      @fixed_customer_activities = Activity.where(event_id: params[:id]).where(fixed_role_type: 1)
      @fixed_advisor_activities = Activity.where(event_id: params[:id]).where(fixed_role_type: 2)
    end
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
    Person.all.each do |person|
      @event.activities.build(person_id: person.id, attendance_type: 2)
    end
  end

  # GET /events/1/edit
  def edit
    Person.all.each do |person|
      if Activity.where(event_id: @event.id, person_id: person.id).blank?
        @event.activities.build(event_id: @event.id, person_id: person.id, attendance_type: 2)
      end
    end
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

  def fix
    unless params[:q] == 'reset'
      @event.activities.each do |ac|
        ac.update_attributes(fixed_role_type: ac.person.role_type)
      end
      @event.update_attributes(is_fixed: true)
    else
      @event.update_attributes(is_fixed: false)
    end
    redirect_to event_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(Event.column_names.map{|e| e.to_sym} - ['id', 'created_at', 'updated_at'], {activities_attributes: [:event_id, :person_id, :attendance_type, :editor_code, :fixed_role_type]})
    end

    def update_event_params
      params.require(:event).permit(Event.column_names.map{|e| e.to_sym} - ['created_at', 'updated_at'], {activities_attributes: [:id, :event_id, :person_id, :attendance_type, :editor_code, :fixed_role_type]})
    end
end
