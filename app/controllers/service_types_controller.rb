class ServiceTypesController < ApplicationController
  before_action :set_service_type, except: [:index, :new, :create]

  def index
    @service_types = ServiceType.for_org(current_user.organization_id)
  end

  def show
  end

  def new
    @service_type = ServiceType.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_service_type
    @service_type = ServiceType.for_org(current_user.organization_id).find(params[:id])
  end
end
