
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
    cast_search_params
    session["results"] = "user_results"
    @plans = Plan.all
    if search_params[:price].present? && search_params[:coverage_percent].present? && search_params[:max_amount].present? && search_params[:deductible].present?
      # @plans = @plans.by_price(params[:plan][:price])
      @plans = @plans.where('price <= ?', params[:plan][:price].to_i).where('coverage_percent >= ?', params[:plan][:coverage_percent].to_i).where('max_amount >= ?', params[:plan][:max_amount].to_i).where('deductible <= ?', params[:plan][:deductible].to_i)
      render 'index'
    else
      flash.alert = 'Please pass all 4 required inputs'
      render :search
      # render 'search', notice: 'Please pass all 4 required inputs'
    end
  end


  private

  def plan_params
    params.require(:plan).permit(:price, :expiration, :max_amount, :coverage_percent, :deductible, :external_id, :provider, :description, :category)
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def search_params
    @search_params ||= params.require(:plan).permit(:price, :max_amount, :coverage_percent, :deductible).to_h
  end

  def cast_search_params
    search_params[:price] = Range.new(*search_params[:price].scan(/\d+/).map(&:to_i))
    search_params[:coverage_percent] = Range.new(*search_params[:coverage_percent].scan(/\d+/).map(&:to_i))
    search_params[:max_amount] = Range.new(*search_params[:max_amount].scan(/\d+/).map(&:to_i))
    search_params[:deductible] = Range.new(*search_params[:deductible].scan(/\d+/).map(&:to_i))
  end
end
