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
    raise
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
