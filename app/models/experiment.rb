class Experiment < ApplicationRecord
  belongs_to :model
  validates :model_id, presence: true
  validates :parameters, presence: true
  serialize :parameters, Hash

  def pretty_parameters
    return self.parameters.map{ |k,v| "#{k}: #{v}" }.join(" | ")
  end

end
