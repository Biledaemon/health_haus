class PaymentsController < ApplicationController
  def new
    @contract = current_user.orders.where(state: 'pending').find(params[:contract_id])
  end
end
