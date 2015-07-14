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
    @query[0] = 'SELECT * FROM (SELECT DISTINCT done, deadline
                                FROM "tasks"
                                ORDER BY done) AS sub
                 ORDER BY done'
    @header[0] = ["Done?","Deadline"]

    @query[1] = ' SELECT projects.name, COUNT(distinct tasks.id) as task_count
                  FROM  tasks INNER JOIN projects ON (projects.id = tasks.project_id)
                  GROUP BY projects.id
                  ORDER BY task_count DESC'
    @header[1] = ["Project name","Task Count"]
    @query[2] = ' SELECT projects.name, COUNT(distinct tasks.id) as task_count
                  FROM  tasks INNER JOIN projects ON (projects.id = tasks.project_id)
                  GROUP BY projects.id
                  ORDER BY projects.name ASC'
    @header[2] = ["Project name","Task Count"]

    @query[3] = ' SELECT *
                  FROM projects INNER JOIN tasks ON (projects.id = tasks.project_id)
                  WHERE projects.name LIKE \'N%\''
    @header[3] = ["ID", "Name","User_id","Created_at","Updated_at","Priority","Done?","Deadline","Project_id"]

    @query[4] = ' SELECT projects.*, COUNT(distinct tasks.id) as task_count
                  FROM projects LEFT OUTER JOIN tasks ON tasks.project_id = projects.id
                  WHERE projects.name LIKE \'%_a_%\'
                  GROUP BY projects.id'
    @header[4] = ["ID", "Name","User_id","created_at","updated_at","TaskCount"]

    @query[5] = ' SELECT name, COUNT(*)
                  FROM tasks
                  GROUP BY name
                  HAVING COUNT(*)>1'
    @header[5] = [ "Name", "Count"]

    @query[6] = ' SELECT tasks.name, done, deadline, COUNT(*)
                  FROM tasks INNER JOIN projects ON (projects.id = tasks.project_id)
                  WHERE projects.name = \'Garage\'
                  GROUP BY tasks.name, done, deadline
                  HAVING COUNT(*)>1
                  ORDER BY COUNT(*) ASC'
    @header[6] = ["Name", "Done?","Deadline", "matches"]

    @query[7] = ' SELECT projects.name, COUNT(*)
                  FROM  tasks INNER JOIN projects ON (projects.id = tasks.project_id)
                  WHERE tasks.done = \'T\'
                  GROUP BY projects.id
                  HAVING COUNT(*)>10
                  ORDER BY projects.id ASC'
    @header[7] = ["Project name","Done Task Count"]


    for i in 0...@query.count
      @sql[i] = sql.execute(@query[i])
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
