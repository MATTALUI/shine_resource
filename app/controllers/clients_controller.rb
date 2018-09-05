class ClientsController < ApplicationController
  def index
    @search  = params[:search].presence
    @clients = Client.all.order(first_name: :asc)
    @clients = @clients.search(@search) if @search.present?
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new
    raise
  end

  def edit
  end

  def update
  end

  def destroy
  end
  private
    def client_params
      params.require(:client).permit(:first_name, :last_initial, :addr1, :addr2, :dob, :description, :services_needed, :ideal_providor, :important_to_me, :important_for_me, :additional_info, :shine_services, :town, :state)
    end
end
