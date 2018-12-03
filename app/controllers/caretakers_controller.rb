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
    timezone_info = "#{timezone_info.name}|#{timezone_info.utc_offset/3600}"
    params[:caretaker][:timezone_info] = timezone_info
    @token = generate_reset_token
    while Caretaker.exists?(password_reset_token: @token) do
      @token = generate_reset_token
    end
    params[:caretaker][:password_reset_token] = @token
    params[:caretaker][:organization_id] = current_user.organization_id
    @caretaker = Caretaker.new(caretaker_params)
    if @caretaker.save then
      redirect_to caretakers_path
      CaretakerMailer.with(caretaker: @caretaker, token: @token, current_user: current_user).new_caretaker_mail.deliver_now
    else
      raise
    end
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

  def password
  end

  def update_password
  end

  private
  def caretaker_params
    return params.require(:caretaker).permit(:first_name, :last_name, :email, :timezone_info, :phone, :master, :password, :password_reset_token, :organization_id)
  end

  def generate_reset_token
    return (1..69).map{[*1..9, *'a'..'z', *'A'..'Z'].sample}.join
  end

end
