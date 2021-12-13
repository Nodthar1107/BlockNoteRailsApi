class Changings3 < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :user, index: false, null: false
  end
end
