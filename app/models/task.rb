class Task < ActiveRecord::Base

  belongs_to :project
  validates :name, presence: true, length: {maximum: 100}


  before_save :set_default_priority
  def prioritizeUp
  	taskAbove = "SELECT * FROM tasks
  								WHERE project_id = ?
  								AND priority > ?
  								ORDER BY priority ASC LIMIT 1",project_id,priority
    q = Task.find_by_sql(taskAbove).first
    unless q.nil?
    	q.update_attribute(:priority, q.priority-1)
      save(q)
    	update_attribute(:priority, priority+1)
      #Return for AJAX livereload
      return "#{id};#{q.id}"
    else
      raise "No tasks above"
    end
  end

  def prioritizeDown
  	taskDown = "SELECT * FROM tasks
  								WHERE project_id = ?
  								AND priority < ?
  								ORDER BY priority DESC LIMIT 1",project_id,priority
  	q = Task.find_by_sql(taskDown).first
    unless q.nil?
    	q.update_attribute(:priority, q.priority+1)
    	update_attribute(:priority, priority-1)
      #Return for AJAX livereload
      return "#{id};#{q.id}"
    else
      raise "No tasks below"
    end
  end

  private
    #gets top task priority
    def get_top_priority
      topTaskQuery = "SELECT * FROM tasks
                      WHERE project_id = ?
                      ORDER BY priority DESC LIMIT 1",self.project
      result = Task.find_by_sql(topTaskQuery)
      (result.first ? result.first.priority : -1)
    end

    #by default new tasks set at the top
    def set_default_priority
      self.priority ||= (get_top_priority+1)
    end
end
