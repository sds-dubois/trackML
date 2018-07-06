class Experiment < ApplicationRecord
  belongs_to :model
  validates :model_id, presence: true
  validates :parameters, presence: true
  serialize :parameters, Hash
  require "csv"

  def pretty_parameters(delimiter = " | ")
    return self.parameters.map{ |k,v| "#{k}: #{v}" }.join(delimiter)
  end

  def csv_headers
    return ["id", "score", "metric", "created_at", "parameters"]
  end

  def csv_dump
    return [self.id, self.score, self.metric, self.created_at, self.parameters.map{ |k,v| "#{k}:#{v}" }.join("|")]
  end

  def self.export_model(model_id)
    experiments = Experiment.where(model_id: model_id)
    if experiments.count == 0
      return nil, nil
    else
      file = CSV.generate do |csv|
        csv << experiments.first.csv_headers()
        experiments.each{ |exp| csv << exp.csv_dump() }
      end
      filename = "model_#{model_id}.csv"
      return file, filename
    end
  end


end
