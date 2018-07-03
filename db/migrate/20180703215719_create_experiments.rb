class CreateExperiments < ActiveRecord::Migration[5.0]
  def change
    create_table :experiments do |t|
      t.text :parameters
      t.float :score
      t.string :metric
      t.references :model, foreign_key: true


      t.timestamps
    end
    add_index :experiments, [:model_id, :created_at]
  end
end
