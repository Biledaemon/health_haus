class ContractsController < ApplicationController
  before_action :set_plan, only: %i[new create]

  def index
    @contracts = current_user.contracts
  end

  def new
    @contract = Contract.new
    @plan = Plan.find(params[:plan_id])
  end

  def create
    @contract = Contract.new
    @contract.plan = @plan
    @contract.user = current_user
    @contract.save
    redirect_to current_user
  end

  def confirm
    @contract = Contract.find(params[:id])
  end

  private

  def contract_params
    params.require(:contract).permit(:plan, :user)
  end

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end
end
