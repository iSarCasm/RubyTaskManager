class UsersController < ApplicationController
  def show
  	@project = Project.new
  	if signed_in?
  		@projects = Project.where('user_id = ?', current_user.id)
  	else 
  		@projects = Array.new(0)
  	end
  	@task = Task.new
  end

  def create
  end

  def destroy
  	flash[:danger] = "Logout!"
  	sign_out current_user
  	redirect_to root_url
  end
end
