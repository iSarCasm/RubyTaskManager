class ProjectsController < ApplicationController
	def create
		@project = current_user.projects.build(	name: 	get_params[:name],
																				 			date: 	Time.zone.now)
		@project.save;
		@task = Task.new
		respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
	end

	def update
		@project = Project.find(params[:id])
		@project.update(name: get_params[:name])
		respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
	end

	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
	end

	private 
		def get_params
			params.require(:project).permit(:name)
		end
end
