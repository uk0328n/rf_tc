class PeopleController < ApplicationController
  before_action :set_person, only: [:customer_show, :customer_edit, :customer_update, :customer_destroy, :advisor_show, :advisor_edit, :advisor_update, :advisor_destroy]
  before_action :authenticate_admin!

  def customers_index
    @customers = Person.where(role_type:1)
    case params[:q]
    when '1'
      @customers = @customers.where(rank: 1)
      @rank = '1'
    when '2'
      @customers = @customers.where(rank: 2)
      @rank = '2'
    when '3'
      @customers = @customers.where(rank: 3)
      @rank = '3'
    else
      @rank = 'all'
    end
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string(template: "people/customers_index.csv.ruby"), filename: "customers_rank#{@rank}.csv", type: :csv
      end
    end
  end

  def customers_import
    if params[:file].present?
      Person.simple_import(params[:file].path, ',')
    end
    redirect_to customers_url
  end

  # GET /customers/1
  # GET /customers/1.json
  def customer_show
    @events = Event.includes(:activities).where(is_fixed: true).where('activities.person_id = ?', @customer.id).where('activities.attendance_type = 1').references(:activities)
    if params[:event_date_gteq].present? || params[:event_date_lteq].present?
      @q = @events.where('event_date >= :event_date_gteq AND event_date <= :event_date_lteq', event_date_gteq: params[:event_date_gteq], event_date_lteq: params[:event_date_lteq])
      @events = @q
    end
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string(template: "people/customer_show.csv.ruby"), filename: "customer_#{@customer.name}_rank#{@customer.rank}.csv", type: :csv
      end
    end
  end

  # GET /customers/new
  def customer_new
    @customer = Person.new(role_type: 1)
  end

  # GET /customers/1/edit
  def customer_edit
  end

  # POST /customers
  # POST /customers.json
  def customer_create
    @customer = Person.new(person_params)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to new_customer_path, notice: 'データが新規作成されました。' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def customer_update
    respond_to do |format|
      if @customer.update(person_params)
        format.html { redirect_to customer_path, notice: 'データが更新されました。' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def customer_destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'データが削除されました。' }
      format.json { head :no_content }
    end
  end

  def advisors_index
    @advisors = Person.where(role_type: 2)
    case params[:q]
    when '1'
      @advisors = @advisors.where(rank: 1)
      @rank = '1'
    when '2'
      @advisors = @advisors.where(rank: 2)
      @rank = '2'
    when '3'
      @advisors = @advisors.where(rank: 3)
      @rank = '3'
    else
      @rank = 'all'
    end
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string(template: "people/advisors_index.csv.ruby"), filename: "advisors_rank#{@rank}.csv", type: :csv
      end
    end
  end

  def advisors_import
    if params[:file].present?
      Person.simple_import(params[:file].path, ',')
    end
    redirect_to advisors_url
  end

  # GET /advisors/1
  # GET /advisors/1.json
  def advisor_show
  end

  # GET /advisors/new
  def advisor_new
    @advisor = Person.new(role_type: 2)
  end

  # GET /advisors/1/edit
  def advisor_edit
  end

  # POST /advisors
  # POST /advisors.json
  def advisor_create
    @advisor = Person.new(person_params)
    respond_to do |format|
      if @advisor.save
        format.html { redirect_to new_advisor_path, notice: 'データが新規作成されました。' }
        format.json { render :show, status: :created, location: @advisor }
      else
        format.html { render :new }
        format.json { render json: @advisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advisors/1
  # PATCH/PUT /advisors/1.json
  def advisor_update
    respond_to do |format|
      if @advisor.update(person_params)
        format.html { redirect_to advisor_path, notice: 'データが更新されました。' }
        format.json { render :show, status: :ok, location: @advisor }
      else
        format.html { render :edit }
        format.json { render json: @advisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advisors/1
  # DELETE /advisors/1.json
  def advisor_destroy
    @advisor.destroy
    respond_to do |format|
      format.html { redirect_to advisors_url, notice: 'データが削除されました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @customer = Person.find(params[:id])
      @advisor = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(Person.column_names.map{|c| c.to_sym} - ['id', 'created_at', 'updated_at'])
    end
end
