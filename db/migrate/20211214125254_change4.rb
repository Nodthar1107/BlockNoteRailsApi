class Change4 < ActiveRecord::Migration[6.1]
  def change
    add_column :blocks, :struct_number, :bigint, null: false
  end
end
