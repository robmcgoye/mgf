class UsersController < ApplicationController
  before_action :require_admin

  def show
    @user = User.find(params[:id])
  end
  
end