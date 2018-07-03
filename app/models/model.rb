class Model < ApplicationRecord
  belongs_to :project
  has_many :experiments
  validates :project_id, presence: true
end
