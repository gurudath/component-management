class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email_id
      t.string :password
      t.date :reset_max_date 
      t.string :login_name
      t.string :reset_key

      t.timestamps
    end
  end
end
