class AdvisorsController < ApplicationController
  before_action :set_advisor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /advisors
  # GET /advisors.json
  def index
    @advisors = Advisor.where.not(is_disable: TRUE)
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string(template: "advisors/index.csv.ruby"), filename: "advisors.csv", type: :csv
      end
    end
  end

  def import
    if params[:file].present?
      Advisor.simple_import(params[:file].path, ',')
    end
    redirect_to advisors_url
  end

  # GET /advisors/1
  # GET /advisors/1.json
  def show
    @customer = Customer.new
    @person = Person.find_by(advisor_id: @advisor.id)
    if @person.present?
      @existing_customer = Customer.find(@person&.customer_id)
      if @existing_customer.present?
        @customer_id = @existing_customer&.id
      end
    end
  end

  # GET /advisors/new
  def new
    @advisor = Advisor.new
  end

  # GET /advisors/1/edit
  def edit
  end

  # POST /advisors
  # POST /advisors.json
  def create
    @advisor = Advisor.new(advisor_params)
    @customer = Customer.find_by(name: @advisor.name, company: @advisor.company)
    if @customer.present?
      @customer.update_attributes(is_disable: TRUE)
    end
    respond_to do |format|
      if @advisor.save
        if @customer.present?
          @person = Person.create(customer_id: @customer&.id, advisor_id: @advisor.id)
        end
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
  def update
    @person = Person.find_by(advisor_id: @advisor.id)
    if Customer.find(@person&.customer_id).present?
      Customer.find(@person&.customer_id).update_attributes(is_disable: TRUE)
    end
    respond_to do |format|
      if @advisor.update(advisor_params)
        format.html { redirect_to @advisor, notice: 'データが更新されました。' }
        format.json { render :show, status: :ok, location: @advisor }
      else
        format.html { render :edit }
        format.json { render json: @advisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advisors/1
  # DELETE /advisors/1.json
  def destroy
    @advisor.destroy
    respond_to do |format|
      format.html { redirect_to advisors_url, notice: 'データが削除されました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advisor
      @advisor = Advisor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advisor_params
      params.require(:advisor).permit(Advisor.column_names.map{|c| c.to_sym} - ['id', 'created_at', 'updated_at'])
    end
end
