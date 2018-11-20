class AuditsController < ApplicationController
  def show
    @entity = params[:entity].classify.constantize.find(params[:id])
    @audits = @entity.audits
  end
end
