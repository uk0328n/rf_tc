class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all.order('kana COLLATE "ja_JP.utf8" ASC')
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])
    if params[:event_date_gteq].present? || params[:event_date_lteq].present?
      @q = Event.where('event_date >= :event_date_gteq AND event_date <= :event_date_lteq', event_date_gteq: params[:event_date_gteq], event_date_lteq: params[:event_date_lteq])
      @events = @q.includes(:advisors)
    else
      @events = Event.all.includes(:advisors)
    end
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string(template: "customers/show.csv.ruby"), filename: "customer_#{@customer.name}_rank#{@customer.rank}.csv", type: :csv
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

    respond_to do |format|
      if @customer.save
        format.html { redirect_to new_customer_path, notice: 'データが新規作成されました。' }
        # format.html { redirect_to @customer, notice: 'データが新規作成されました。' }
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
