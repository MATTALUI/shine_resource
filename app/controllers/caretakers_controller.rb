class CaretakersController < ApplicationController
  include ActiveSupport
  def index
    @caretakers = Caretaker.where(organization_id: current_user.organization_id)
  end

  def new
    @time_zones = TimeZone.us_zones.sort{|a,b| a.name <=> b.name}
  end

  def create
    timezone_info = TimeZone.us_zones.find{|z| z.name == params.dig(:caretaker, :timezone)}
    timezone_info = "#{timezone_info.name}|#{timezone_info.utc_offset/2600}"
    raise
  end

  def edit
  end

  def show
    @caretaker = Caretaker.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
