class PresetsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @preset = Preset.new
    @clients = current_user.organization.clients
    @types = [:service_description, :location, :interactions, :support_provided, :comments]
  end

  def create
    preset = params[:preset]
    client_ids = preset[:client_id].reject(&:blank?)
    if preset[:active] == "1"
      preset[:active] = true
    else
      preset[:active] = true
    end
    if client_ids.length > 0
      presets = client_ids.map do |client_id|
        preset_params.to_h.merge(client_id: client_id)
      end
      @presets = Preset.create(presets)
    else
      preset[:client_id] = nil
      @preset = Preset.create(preset_params)
    end
    redirect_to presets_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def preset_params
    params.require(:preset).permit(:client_id, :caretaker_id, :preset_type, :short_code, :text, :active)
  end
end
