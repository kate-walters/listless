class Task < ApplicationRecord
  belongs_to :list
  belongs_to :parent, class_name: "Task", foreign_key: :parent_task_id, optional: true
  has_many :children, class_name: "Task", foreign_key: :parent_task_id, dependent: :destroy

  validates :title, length: { minimum: 2, maximum: 200 }
  validates :completed, default: false, inclusion: { in: [true, false] }
  validates :list_id, presence: true

  def as_json(_ = nil)
    super(include: :children)
  end
end
