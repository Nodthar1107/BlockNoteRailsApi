class Change7 < ActiveRecord::Migration[6.1]
  def change
    rename_column :blocks, :next_block_id, :struct_number
    change_column_null :blocks, :struct_number, false
  end
end
