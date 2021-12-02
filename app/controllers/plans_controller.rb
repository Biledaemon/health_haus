class PlansController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_plan, only: :show

  def index
    @plans = Plan.all
  end

  def show
    @contract = Contract.new
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

  def search
    @plan = Plan.new
  end

  def search_results
    # raise
    @plans = Plan.all
    # price
    if params[:plan][:price].present? && params[:plan][:coverage_percent].present? && params[:plan][:max_amount].present? && params[:plan][:deductible].present?
      # @plans = @plans.by_price(params[:plan][:price])
      @plans = @plans.where('price >= ?', params[:plan][:price].to_i).where('coverage_percent >= ?', params[:plan][:coverage_percent].to_i).where('max_amount >= ?', params[:plan][:max_amount].to_i).where('deductible >= ?', params[:plan][:deductible].to_i)
    # coverage_percent
    # max_amount
    # deductible
      render 'results'
    else
      raise "incomplete parameters"
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
