class Experiment < ApplicationRecord
  belongs_to :model
  validates :model_id, presence: true
  validates :parameters, presence: true
  serialize :parameters, Hash
  serialize :scores, Hash
  require "csv"

  def pretty_parameters(delimiter = " | ")
    return self.parameters.map{ |k,v| "#{k}: #{v}" }.join(delimiter)
  end

  def csv_headers
    return ["id", "score", "metric", "created_at", "parameters"]
  end

  def csv_dump(metric, score)
    return [self.id, score, metric, self.created_at, self.parameters.map{ |k,v| "#{k}:#{v}" }.join("|")]
  end

  def self.export_model(model_id)
    experiments = Experiment.where(model_id: model_id)
    if experiments.count == 0
      return nil, nil
    else
      file = CSV.generate do |csv|
        csv << experiments.first.csv_headers()
        Experiment.detailed_list(experiments).each{ |exp,metric,score| csv << exp.csv_dump(metric, score) }
      end
      filename = "model_#{model_id}.csv"
      return file, filename
    end
  end

  def self.detailed_list(experiments)
    return experiments.map{ |e| e.scores.map{ |k,v| [e, k, v] } }.reduce([], &:+)
  end


end
