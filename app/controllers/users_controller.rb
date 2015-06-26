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

    @query[0] = 'Task.select(:done, :deadline).order(name: :asc).distinct'
    @sql[0] = Task.select("tasks.name, DISTINCT ON (tasks.done, tasks.deadline)").order(name: :asc)
    @header[0] = ["ID","Name","Done?","Deadline"]




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
