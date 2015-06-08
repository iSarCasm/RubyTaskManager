class TasksController < ApplicationController
  def create
  	project = Project.find(get_params[:project_id])
  	@task = project.tasks.build(	name: 				get_params[:name],
  																deadline: 		get_params[:deadline])
  	if @task.save
  		flash[:succes] = "ez pzzz"
  	else 
  		flash[:danger] = "wtffff"
  	end
  	redirect_to root_url
  end

  def update
  end

  def destroy
  end

  private 
  	def get_params
  		params.require(:task).permit(:name,:deadline,:project_id)
  	end
end
