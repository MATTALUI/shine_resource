class OrganizationsController < ApplicationController
  include ActiveSupport
  def show
    @organization = Organization.find(params[:id])
  end

  def edit
    @organization = Organization.find(params[:id])
    @time_zones   = TimeZone.us_zones.sort{|a,b| a.name <=> b.name}
    @colors       = ORG_COLORS.keys.map{|color| [color.titleize, color]}
  end

  def update
    @organization = Organization.find(params[:id])
    timezone_info = TimeZone.us_zones.find{|z| z.name == params.dig(:organization, :timezone)}
    timezone_info = "#{timezone_info.name}|#{timezone_info.utc_offset/3600}"
    params[:organization][:timezone_info] = timezone_info
    @organization.update(organization_params)
    redirect_to organization_path(@organization)
  end

  private
  def organization_params
    params.require(:organization).permit(:name, :timezone_info, :color)
  end
end
