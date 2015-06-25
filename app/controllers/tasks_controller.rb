class TasksController < ApplicationController
  def create
  	project = Project.find(get_params[:project_id])
  	@task = project.tasks.create(	name: 				get_params[:name],
  																deadline: 		get_params[:deadline],
                                  priority:     get_priority(project),
                                  done:         0)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def update_title
    @task = Task.find(params[:id])
    @task.update(name: get_params[:name])
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end


  def update_deadline
    date = Date.new Time.now.year, get_params["deadline(2i)"].to_i, get_params["deadline(3i)"].to_i
    @task = Task.find(params[:id])
    @task.update(deadline: date)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def done
    @task = Task.find(params[:id])
    @task.update(done: get_params[:done])
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def prioritizeUp
    @task = Task.find(params[:id])
    @result = @task.prioritizeUp
     # redirect_to root_url
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def prioritizeDown
    @task = Task.find(params[:id])
    @result = @task.prioritizeDown
    # redirect_to root_url
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  private 
  	def get_params
  		params.require(:task).permit(:name,:project_id, :done, "deadline(1i)","deadline(2i)", "deadline(3i)")
  	end

    def get_priority(project)
      topTaskQuery = "SELECT * FROM tasks
                      WHERE project_id = ?
                      ORDER BY priority DESC LIMIT 1",project
      result = Task.find_by_sql(topTaskQuery)
      (result.first ? result.first.priority+1 : 0)
    end
end
