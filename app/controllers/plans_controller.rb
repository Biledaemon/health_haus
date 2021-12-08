
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
    session["results"] = "user_results"
    @plans = Plan.all
    if params[:plan][:price].present? && params[:plan][:coverage_percent].present? && params[:plan][:max_amount].present? && params[:plan][:deductible].present?
      # @plans = @plans.by_price(params[:plan][:price])
      @plans = @plans.where('price >= ?', params[:plan][:price].to_i).where('coverage_percent >= ?', params[:plan][:coverage_percent].to_i).where('max_amount >= ?', params[:plan][:max_amount].to_i).where('deductible >= ?', params[:plan][:deductible].to_i)
      render 'index'
    else
      flash.alert = 'Please pass all 4 required inputs'
      render :search
      # render 'search', notice: 'Please pass all 4 required inputs'
    end
  end

  def import
    # Obtain the 4 params obtained from user 'Search'
    # Scrape from queplan.cl
    # GET the price (convert to $)
    # GET the coverage_percent,
    # GET the max_amount (convert to $),
    # GET deductible (comvert to $)
    # Create an array of plans for user (individual, couple or Family) Cron job? LIMIT = 100 plans
  end

  private

  # def load_csv
  #   CSV.foreach(@csv_file) do |row|
  #     @jobs << Plan.new(provider: row[0], price: row[1], deductible: row[2], max_amount: row[3, coverage_percent: row[4])
  #   end
  # end

  def plan_params
    params.require(:plan).permit(:price, :expiration, :max_amount, :coverage_percent, :deductible, :external_id, :provider, :description, :category)
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end
end
