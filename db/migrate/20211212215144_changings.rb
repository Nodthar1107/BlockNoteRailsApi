class Changings < ActiveRecord::Migration[6.1]
  def change
    remove_column :blocks, :project_id
    add_reference :projects, :block, index: false, null: false
  end
end
