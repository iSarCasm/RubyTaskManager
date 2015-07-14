class UsersController < ApplicationController
  def show
  	@project = Project.new
  	if signed_in?
  		@projects = Project.where('user_id = ?', current_user.id).order('projects.created_at DESC')
  	else
  		@projects = Array.new(0)
  	end
  	@task = Task.new
  end

  def create
  end

  def destroy
  	sign_out current_user
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def sql
    @query = Array.new
    @sql = Array.new
    @parsed = Array.new
    @header = Array.new

    sql = ActiveRecord::Base.connection()
    # @query[0] = 'Task.select(:done, :deadline).order(name: :asc).distinct'
    @query[0] = 'SELECT * FROM (SELECT DISTINCT ON (done) Task.done, Task.*
                                FROM "Task"
                                ORDER BY done)
                ORDER BY name'
    @sql[0] = sql.execute(@query[0])
    @header[0] = ["ID","Done?","Deadline"]

    @query[1] = 'Task.joins(:project).group(:project_id).select("projects.name, COUNT(*) as TaskCount").order("TaskCount DESC")'
    @sql[1] = Task.joins(:project).group(:project_id).select("projects.name, COUNT(*) as TaskCount").order("TaskCount DESC")
    @header[1] = ["ID", "Project name","Task Count"]

    @query[2] = 'Task.joins(:project).group(:project_id).select("projects.name, COUNT(*) as TaskCount").order("projects.name ASC")'
    @sql[2] = Task.joins(:project).group(:project_id).select("projects.name, COUNT(*) as TaskCount").order("projects.name ASC")
    @header[2] = ["ID", "Project name","Task Count"]

    @query[3] = ' Task.select("projects.name AS pName","tasks.*").joins(:project).where("projects.name LIKE ?","N%"")'
    @sql[3] = Task.select("projects.name AS pName","tasks.*").joins(:project).where("projects.name LIKE ?",'N%')
    @header[3] = ["ID", "Name","priority","done?","deadline","project_id","created_at","updated_at","Project name"]

    @query[4] = 'Project.joins("LEFT OUTER JOIN tasks ON projects.id = tasks.project_id").group(:project_id).select("projects.*, COUNT(tasks.project_id) as TaskCount")
              .where("projects.name LIKE ?","%_a_%")'
    @sql[4] = Project.joins("LEFT OUTER JOIN tasks ON 'projects'.'id'='tasks'.'project_id'").group(:project_id).select("projects.*, COUNT(tasks.project_id) as TaskCount")
              .where("projects.name LIKE ?","%_a_%")
    @header[4] = ["ID", "Name","User_id","created_at","updated_at","TaskCount"]

    @query[5] = 'Task.group(:name).having("COUNT(*)>1").order(name: :asc)'
    @sql[5] = Task.group(:name).having("COUNT(*)>1").order(name: :asc)
    @header[5] = ["ID", "Name","priority","done?","deadline","project_id","created_at","updated_at"]

    @query[6] = ' Task.joins(:project).where("projects.name = ?","Garage").group("tasks.name, tasks.done, tasks.deadline").having("COUNT(*)>1").select("tasks.*, COUNT(*)").order("COUNT(*) DESC")'
    @sql[6] = Task.joins(:project).where("projects.name = 'Garage'").group("tasks.name, tasks.done, tasks.deadline").having("COUNT(*)>1").select("tasks.*, COUNT(*)").order("COUNT(*) DESC")
    @header[6] = ["ID", "Name","priority","done?","deadline","project_id","created_at","updated_at","Matches"]

    @query[7] = ' Task.where("tasks.done = ?",true).joins(:project).group(:project_id).having("COUNT(*)>=10").select("projects.name, COUNT(*) as TaskCount").order("projects.id DESC")'
    @sql[7] = Task.where("tasks.done = ?",true).joins(:project).group(:project_id).having("COUNT(*)>=10").select("projects.name, COUNT(*) as TaskCount").order("projects.id DESC")
    @header[7] = ["ID", "Project name","Done Task Count"]


    for i in 0..@sql.count-1
      @parsed[i] = @sql[i].as_json.to_a
      @parsed[i] = @parsed[i].to_s.delete("[").delete("]").split("},")
      for x in 0..@parsed[i].count-1
        y = @parsed[i][x].delete("{").delete('}').split(', "')
        for z in 0..y.count-1
          y[z]  = y[z].split("=>")[1]
        end
        @parsed[i][x] = y
      end
    end
  end
end
