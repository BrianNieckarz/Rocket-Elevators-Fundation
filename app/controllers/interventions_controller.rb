class InterventionsController < ApplicationController
  before_action :set_intervention, only: %i[ show edit update destroy ]

  # GET /interventions or /interventions.json
  def index
    @interventions = Intervention.all
  end

  # GET /interventions/1 or /interventions/1.json
  def show
  end

  # GET /interventions/new
  def new
    @intervention = Intervention.new
    @customer = Customer.all
    @building = Building.all
    @battery = Battery.all
    @column = Column.all
    @elevator = Elevator.all
    @employee = Employee.all
    @author = current_user.first_name
    @authoremail = current_user.email
  end

  # GET /interventions/1/edit
  def edit
  end

  def create
    puts "create intervention function works ---------------------------------------------"
    @intervention = Intervention.new(intervention_params)
    @intervention.author = current_user.first_name + " " + current_user.last_name


    my_uri = "https://#{ENV['FRESHDESK_DOMAIN']}.freshdesk.com/api/v2/tickets"
    my_key = ENV['FRESHDESK_API_KEY']

    respond_to do |format|
      if @intervention.save
        format.html { redirect_to "/", notice: "Good. Intervention created successfully!" }
        format.json { render :show, status: :created, location: @intervention }

        site = RestClient::Resource.new(my_uri, my_key, 'X')

          data_hash = {
            status: 2,
            priority: 1,
            subject: "#{@intervention.result} from #{@intervention.author}", 
            description: 
            "The requester #{@intervention.author} started a new intervention
            for company #{@intervention.customer_id} //
            On builging ID #{@intervention.building_id} // 
            On battery ID #{@intervention.battery_id} //
            On column ID #{@intervention.column_id} //
            On elevator ID #{@intervention.elevator_id} //
            Job is done by employee ID #{@intervention.employee_id} //
            The job description #{@intervention.report}
              ",
            
            email: "#{current_user.email}",
            type:"Question"
          }
          
          data_json = JSON.generate(data_hash)
          # site.post(data_json)
          RestClient::Request.execute(
            method: :post,
            url: my_uri,
            user: my_key,
            password: 'X',
            payload: data_json,
            headers: {"Content-Type" => "application/json"},
          )

      

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @intervention.update(intervention_params)
        format.html { redirect_to intervention_url(@intervention), notice: "Intervention was successfully updated." }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @intervention.destroy

    respond_to do |format|
      format.html { redirect_to interventions_url, notice: "Intervention was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  # Building From Customer
  def get_building_by_customer
    @building = Building.where("customer_id = ?", params[:customer_id])
    respond_to do |format|
        format.json { render :json => @building }
    end
  end

  # Battery From Building
  def get_battery_by_building
    @battery = Battery.where("building_id = ?", params[:building_id])
    respond_to do |format|
        format.json { render :json => @battery }
    end
  end

  # Column From Battery
  def get_column_by_battery
    @column = Column.where("battery_id = ?", params[:battery_id])
    respond_to do |format|
        format.json { render :json => @column }
    end
  end

  # Elevator From Column
  def get_elevator_by_column
    @elevator = Elevator.where("column_id = ?", params[:column_id])
    respond_to do |format|
        format.json { render :json => @elevator }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def intervention_params
      params.require(:intervention).permit(:author, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :report)
    end
end