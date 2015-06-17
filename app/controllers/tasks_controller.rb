class TasksController < ApplicationController
  def create
  	project = Project.find(get_params[:project_id])
  	@task = project.tasks.build(	name: 				get_params[:name],
  																deadline: 		get_params[:deadline],
                                  priority:     get_priority(project),
                                  done:         0)
  	if @task.save
  		flash[:succes] = "ez pzzz"
  	else 
  		flash[:danger] = "wtffff"
  	end
  	redirect_to root_url
  end

  def update
    date = Date.new Time.now.year, get_params["deadline(2i)"].to_i, get_params["deadline(3i)"].to_i
    Task.find(params[:id]).update(name: get_params[:name], deadline: date)
    flash[:danger] = date.to_s
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
  		params.require(:task).permit(:name,:project_id, :done, "deadline(2i)", "deadline(3i)")
  	end

    def get_priority(project)
      topTaskQuery = "SELECT * FROM tasks
                      WHERE project_id = ?
                      ORDER BY priority DESC LIMIT 1",project
      result = Task.find_by_sql(topTaskQuery)
      (result.first ? result.first.priority+1 : 0)
    end
end
