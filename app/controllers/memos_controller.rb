class MemosController < ApplicationController
  def show
  end

  def create
    @client = Client.find(params.dig(:memo, :client_id))
    @memo = Memo.new(memo_params)
    @memo.caretaker_id = current_user.id
    @memo.save
    redirect_back fallback_location: root_path
  end

  def destroy
  end
  private
    def memo_params
      params.require(:memo).permit(:client_id, :body)
    end
end
