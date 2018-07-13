class ModifyExperimentsOutput < ActiveRecord::Migration[5.0]
  def change
    remove_column :experiments, :score
    remove_column :experiments, :metric
    add_column :experiments, :scores, :string
  end
end
