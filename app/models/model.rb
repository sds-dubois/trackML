class Model < ApplicationRecord
  belongs_to :project
  has_many :experiments, dependent: :destroy
  validates :project_id, presence: true

  def csv_headers
    return ["id", "name", "comments"]
  end

  def csv_dump
    return [self.id, self.name, self.comment]
  end

end
