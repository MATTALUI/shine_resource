class CaretakersController < ApplicationController
  def index
    @caretakers = Caretaker.where(organization_id: current_user.organization_id)
  end

  def create
  end

  def new
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
