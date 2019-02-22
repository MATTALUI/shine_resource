class ServiceTypesController < ApplicationController
  before_action :set_service_type, except: [:index, :new, :create]
  before_action :validate_organization_id, only: [:create, :update]

  def index
    @service_types = ServiceType.for_org(current_user.organization_id)
  end

  def show
    raise
  end

  def new
    @service_type = ServiceType.new
  end

  def create
    @service_type = ServiceType.new(service_type_params)
    if @service_type.save
      flash[:success] = "Service Type #{@service_type} created."
    else
      flash[:error] = "Sorry. Something went wrong."
    end
    redirect_to service_types_path
  end

  def edit
  end

  def update
    if @service_type.update(service_type_params)
      flash[:success] = "Service Type #{@service_type} updated."
    else
      flash[:error] = "Sorry. Something went wrong."
    end
    redirect_to service_types_path
  end
 
  def destroy
    raise
  end

  private
  def service_type_params
    params.require(:service_type).permit(:name, :active, :organization_id)
  end

  def set_service_type
    @service_type = ServiceType.for_org(current_user.organization_id).find(params[:id])
  end

  def validate_organization_id
    head :forbidden unless current_user.organization_id == params[:service_type][:organization_id].presence
  end
end
