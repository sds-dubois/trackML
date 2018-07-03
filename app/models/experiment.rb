class Experiment < ApplicationRecord
  belongs_to :model
  validates :model_id, presence: true
  validates :parameters, presence: true
end
