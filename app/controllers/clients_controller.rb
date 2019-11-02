require 'rack/mime'
class ClientsController < ApplicationController
  before_action :check_admin, only: [:create, :edit, :update, :destroy]
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  def index
    @search  = params[:search].presence
    @clients = Client.with_org(current_user.organization_id).order(first_name: :asc)
    @clients = @clients.search(@search) if @search.present?
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.organization_id = current_user.organization.id
    @client.save
    @client.dob = Date.parse(params.dig(:client, :dob)).to_s rescue nil
    uploaded_picture = params.dig(:client, :photo)
    if uploaded_picture.present?
      dir = File.join(Rails.root, 'public', 'system', 'photos', @client.id)
      ext = Rack::Mime::MIME_TYPES.invert[uploaded_picture.content_type]
      filename = "#{@client.first_name}-#{@client.last_initial}#{ext}"
      new_file = File.join(dir, filename)
      FileUtils.mkdir_p(dir)
      File.open(new_file, 'wb'){|f| f.write(uploaded_picture.read)}
      photo_url = File.join(Rails.root, "/system/photos/#{@client.id}/#{filename}")
    else
      photo_url = DEFAULT_PHOTO
    end
    @client.update_attribute(:photo_url, photo_url)
    redirect_to clients_path
  end

  def edit
  end

  def update
    @client.update(client_params)
    flash[:success] = 'Client Successfully Updated.'
    redirect_to clients_path(@client)
  end

  def destroy
    @client.delete
    flash[:notice] = 'Client Successfully Deleted'
    redirect_to clients_path
  end
  private
    def client_params
      params.require(:client).permit(:first_name, :last_initial, :addr1, :addr2, :description, :services_needed, :ideal_provider, :important_to_me, :important_for_me, :additional_info, :shine_services, :town, :state)
    end

    def set_client
      @client = Client.find(params[:id])
    end
end
