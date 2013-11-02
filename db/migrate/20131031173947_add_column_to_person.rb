class AddColumnToPerson < ActiveRecord::Migration
  def change
    add_column :people, :content, :text
  end
end
