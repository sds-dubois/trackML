class CreateModels < ActiveRecord::Migration[5.0]
  def change
    create_table :models do |t|
      t.string :name
      t.text :comment
      t.references :project, foreign_key: true

      t.timestamps
    end
    add_index :models, [:project_id, :created_at]

  end
end
