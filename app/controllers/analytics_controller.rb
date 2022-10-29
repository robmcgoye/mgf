class AnalyticsController < ApplicationController
  before_action :require_admin

  def dashboard
    if params[:days].present?
      @days = params[:days].to_i
    else
      @days = 7
    end 
  end
  
end