class Task < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true, length: {maximum: 100}
end
