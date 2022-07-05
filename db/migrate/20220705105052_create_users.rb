class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :dob
      t.string :email, null: false
      t.string :password, null: false
      t.timestamps
    end
  end
end
