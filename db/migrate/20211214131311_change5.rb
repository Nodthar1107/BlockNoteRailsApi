class Change5 < ActiveRecord::Migration[6.1]
  def change
    rename_column :blocks, :struct_number, :next_block_id
  end
end
