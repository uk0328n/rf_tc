class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.where.not(is_disable: TRUE)
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
        send_data render_to_string(template: "customers/index.csv.ruby"), filename: "customers_rank#{@rank}.csv", type: :csv
      end
    end
  end

  def import
    if params[:file].present?
      Customer.simple_import(params[:file].path, ',')
    end
    redirect_to customers_url
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @events = Event.includes(:activities).where('activities.customer_id = ?', @customer.id).where('activities.attendance_type = 1').references(:activities)
    if params[:event_date_gteq].present? || params[:event_date_lteq].present?
      @q = @events.where('event_date >= :event_date_gteq AND event_date <= :event_date_lteq', event_date_gteq: params[:event_date_gteq], event_date_lteq: params[:event_date_lteq])
      @events = @q
    end
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string(template: "customers/show.csv.ruby"), filename: "customer_#{@customer.name}_rank#{@customer.rank}.csv", type: :csv
      end
    end
    @advisor = Advisor.new
    @person = Person.find_by(customer_id: @customer.id)
    if @person.present?
      @existing_advisor = Advisor.find(@person&.advisor_id)
      if @existing_advisor.present?
        @advisor_id = @existing_advisor&.id
      end
    end
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    @advisor = Advisor.find_by(name: @customer.name, company: @customer.company)
    if @advisor.present?
      @advisor.update_attributes(is_disable: TRUE)
    end
    respond_to do |format|
      if @customer.save
        if @advisor.present?
          @person = Person.create(customer_id: @customer.id, advisor_id: @advisor&.id)
        end
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
  def update
    @person = Person.find_by(customer_id: @customer.id)
    if Advisor.find(@person&.advisor_id).present?
      Advisor.find(@person&.advisor_id).update_attributes(is_disable: TRUE)
    end
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'データが更新されました。' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'データが削除されました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(Customer.column_names.map{|c| c.to_sym} - ['id', 'created_at', 'updated_at'])
    end
end
