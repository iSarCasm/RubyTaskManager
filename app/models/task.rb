class Task < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true, length: {maximum: 100}

  def prioritizeUp
  	taskAbove = "SELECT * FROM tasks 
  								WHERE project_id = ?
  								AND priority > ?
  								ORDER BY priority ASC LIMIT 1",project_id,priority
  	q = Task.find_by_sql(taskAbove).first
  	q.update(priority: q.priority-1)
  	update_attribute(:priority, priority+1)
  end

  def prioritizeDown
  	taskDown = "SELECT * FROM tasks 
  								WHERE project_id = ?
  								AND priority < ?
  								ORDER BY priority DESC LIMIT 1",project_id,priority
  	q = Task.find_by_sql(taskDown).first
  	q.update(priority: q.priority+1)
  	update_attribute(:priority, priority-1)
  end
end
