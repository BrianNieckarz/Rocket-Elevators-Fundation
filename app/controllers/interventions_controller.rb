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
  end

  # GET /interventions/1/edit
  def edit
  end

  # POST /interventions or /interventions.json
  def create
    @intervention = Intervention.new(intervention_params)

    respond_to do |format|
      if @intervention.save
        format.html { redirect_to intervention_url(@intervention), notice: "Intervention was successfully created." }
        format.json { render :show, status: :created, location: @intervention }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interventions/1 or /interventions/1.json
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

  # DELETE /interventions/1 or /interventions/1.json
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


  def get_all_employee
    @employee = Employee.all
  end


  def create
    puts "create intervention function works ---------------------------------------------"
    @intervention = Intervention.new(intervention_params)

    my_uri = "https://#{ENV['FRESHDESK_DOMAIN']}.freshdesk.com/api/v2/tickets"
    my_key = ENV['FRESHDESK_API_KEY']

    # respond_to do |format|
    #   if @lead.save
    #     format.html { redirect_to "/", notice: "Thank you. We will communicate with you shortly!" }
    #     format.json { render :show, status: :created, location: @lead }

        # attachment_exists = @lead.attached_file_stored_as_binary.attached?
        # user_is_customer = Customer.where(email_of_the_company_contact: "#{@lead.email}").present? || Customer.where(technical_manager_email_for_service: "#{@lead.email}").present?
        site = RestClient::Resource.new(my_uri, my_key, 'X')
        # client = RestClient::Resource.new

        # if attachment_exists
          
        #   attachment = @lead.attached_file_stored_as_binary.attachment
        #   blob_data = @lead.attached_file_stored_as_binary.blob
        #   blob_path = blob_data.service.path_for(blob_data.key)
          
        #   # NOTE: FRESHDESK
        #   data_hash = {
        #       status: 2,
        #       priority: 1,
        #       subject: "#{@lead.full_name} from #{@lead.company_name}", 
        #       description: "The contact #{@lead.full_name}  from company #{@lead.company_name} can be reached at email #{@lead.email} and at phone number #{@lead.phone}. #{@lead.department_in_charge_of_elevators} has a project named #{@lead.project_name} which would require contribution from Rocket Elevators.\nProject Description: #{@lead.project_description}\n#{@lead.message}.\nThe Contact uploaded an attachment",
        #       email: "#{@lead.email}",
        #       type:"Question",
        #       attachments: [File.new(blob_path, "rb")]
        #     }

        #     # data_json = JSON.generate(data_hash)
        #     site.post(data_hash)

        #     if user_is_customer
        #       # NOTE: DROPBOX
        #       # authenticator = DropboxApi::Authenticator.new(ENV["DROPBOX_KEY"], ENV["DROPBOX_SECRET"])
        #       # authenticator.auth_code.authorize_url(token_access_type: "offline")
        #       # access_token = authenticator.auth_code.get_token(ENV["DROPBOX_ACCESS_CODE"])
        #       # client = DropboxApi::Client.new(access_token: access_token)
        #       client = DropboxApi::Client.new
        #       folder_exists = client.search("#{@lead.full_name}").matches[0]
        #       client.create_folder("/#{@lead.full_name}") unless folder_exists
        #       file_path = "/#{@lead.full_name}/#{blob_data.filename.sanitized}"
        #       response = client.upload(file_path, blob_data.download)
        #       attachment.purge if response.id
        #     end
          
        if
          data_hash = {
            status: 2,
            priority: 1,
            subject: "Intervention ##{@intervention.id}", 
            description: "Author #{@intervention.author_id}  made a intervention for #{@intervention.company_name} \nbuilding ##{@intervention.building_id} \nBattery ##{@intervention.battery_id}\nColumn ##{@intervention.column_id} \nElevator ##{@intervention.elevator_id} \n
            Employee ##{@intervention.employee_id} has been appointed to this case.",
            email: "#{@intervention.current_user.email}",
            type:"Intervention"
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


      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  # end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_intervention
    @intervention = Intervention.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def intervention_params
    params.fetch(:intervention, {})
  end
end