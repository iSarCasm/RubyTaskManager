class ProjectsController < ApplicationController
  def create
  	@project = Project.new(	name: 	get_params[:name],
  													date: 	Time.zone.now)
  	if @project.save
			flash[:succes] = "ez pz"
  	else 
  		flash[:danger] = "wtf"
  	end
  	redirect_to root_url
  end

  def update
  end

  def destroy
  end

  private 
  	def get_params
  		params.require(:project).permit(:name)
  	end
end
