class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :password, null: false
      t.string :phone_number, null: false
      t.string :mail, null: false

      t.timestamps
    end
  end
end
