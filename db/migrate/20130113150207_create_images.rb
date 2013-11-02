class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :name
      t.integer :entity_id
      t.string :entity_type
      t.string :caption
      t.text :description
      t.string :image_path 
      t.timestamps
    end
  end
  def  self.down 
   drop_table :images
  end
end
