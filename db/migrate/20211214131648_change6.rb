class Change6 < ActiveRecord::Migration[6.1]
  def change
    change_column_null :blocks, :next_block_id, true
  end
end
