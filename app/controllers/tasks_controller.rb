class TasksController < ApplicationController
  def create
  	project = Project.find(get_params[:project_id])
  	@task = project.tasks.build(	name: 				get_params[:name],
  																deadline: 		get_params[:deadline],
                                  priority:     get_priority(project))
  	if @task.save
  		flash[:succes] = "ez pzzz"
  	else 
  		flash[:danger] = "wtffff"
  	end
  	redirect_to root_url
  end

  def update
    Task.find(params[:id]).update(name: get_params[:name])
    redirect_to root_url
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to root_url
  end

  def prioritizeUp
    t = Task.find(params[:id]).prioritizeUp
    flash[:danger] = t
    redirect_to root_url
  end

  def prioritizeDown
    t = Task.find(params[:id]).prioritizeDown
    flash[:danger] = t
    redirect_to root_url
  end

  private 
  	def get_params
  		params.require(:task).permit(:name,:deadline,:project_id)
  	end

    def get_priority(project)
      topTaskQuery = "SELECT * FROM tasks
                      WHERE project_id = ?
                      ORDER BY priority DESC LIMIT 1",project
      Task.find_by_sql(topTaskQuery).first.priority + 1
    end
end
