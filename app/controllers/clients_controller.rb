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
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
