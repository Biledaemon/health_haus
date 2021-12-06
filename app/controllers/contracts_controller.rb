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
    plan = Plan.find(params[:plan_id])
    contract = Contract.create!(plan: plan.provider, amount: plan.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: plan.name,
        amount: plan.price,
        currency: 'usd',
        quantity: 1
      }],
      success_url: contract_url(contract),
      cancel_url: contract_url(contract)
    )

    contract.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def confirm
    @contract = Contract.find(params[:id])
  end

  def show
    @contract = current_user.contract.find(params[:id])
  end

  private

  def contract_params
    params.require(:contract).permit(:plan, :user)
  end

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end
end
