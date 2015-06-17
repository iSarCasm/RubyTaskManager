class ProjectsController < ApplicationController
	def create
		@project = current_user.projects.new(	name: 	get_params[:name],
																				 date: 	Time.zone.now)
		if @project.save
			flash[:succes] = "ez pz"
		else 
			flash[:danger] = "wtf"
		end
		redirect_to root_url
	end

	def update
		Project.find(params[:id]).update(name: get_params[:name])
		redirect_to root_url
	end

	def destroy
		Project.find(params[:id]).destroy
		redirect_to root_url
	end

	private 
		def get_params
			params.require(:project).permit(:name)
		end
end
