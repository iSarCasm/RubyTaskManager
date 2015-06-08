class UsersController < ApplicationController
  def show
  	@project = Project.new
  	@projects = Project.all
  	@task = Task.new
  end

  def create
  end

  def destroy
  end
end
