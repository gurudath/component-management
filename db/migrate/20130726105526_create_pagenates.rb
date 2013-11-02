class CreatePagenates < ActiveRecord::Migration
  def change
    create_table :pagenates do |t|
      t.string :first_name
      t.string :email_id

      t.timestamps
    end
  end
end
