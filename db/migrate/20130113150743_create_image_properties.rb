class CreateImageProperties < ActiveRecord::Migration
  def self.up
    create_table :image_properties do |t|
      t.integer :image_id
      t.integer :entity_id
      t.string :entity_type
      t.string :image_path
      t.integer :thumblain_id

      t.timestamps
    end
  end
end
