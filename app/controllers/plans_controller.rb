class PlansController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_plan, only: :show

  def index
    @plans = Plan.all
  end

  def show
    @plan = Contract.new
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to plans_path
    else
      render :new
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:price, :expiration, :max_amount, :coverage_percent, :deductible, :external_id, :provider, :description, :category)
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end
end
