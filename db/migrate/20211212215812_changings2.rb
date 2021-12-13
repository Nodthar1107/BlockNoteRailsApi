class Changings2 < ActiveRecord::Migration[6.1]
  def change
    add_reference :blocks, :project, index: false, null: false
    remove_reference :projects, :block
  end
end
