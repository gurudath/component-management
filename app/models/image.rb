class Image < ActiveRecord::Base
require 'RMagick'
include Magick

#belongs_to :entity, :polymorphic => true
has_one :image_property

def save_image(upload)
   file_name = upload.original_filename
   file =upload.read
   file_type = file_name.split('.').last
   new_name_file = Time.now.to_i
   new_file_name_with_type = "#{file_name.split('.').first}" +"_"+ "#{new_name_file}." + file_type
   image_root = "#{Rails.root}"
   Dir.mkdir(image_root + "/public/images/"+"#{self.id}")
   File.open(image_root + "/public/images/"+"#{self.id}"+"/" + new_file_name_with_type, "wb")  do |f|
      f.write(file)
   end
   self.image_path="/images/"+"#{self.id}"+"/" + new_file_name_with_type
   self.save
end

def resize_image(width=100,height=100)
file_name = self.name
file_type = self.image_path.blank? ? "jpeg" : self.image_path.split('.').last
new_file_name_with_type = "#{file_name.split('.').first}" + "_#{width}_#{height}." + file_type
orginal_path = "#{Rails.root}" + "/public" + "#{self.image_path}"
resize_path = "#{Rails.root}" + "/public/images/"+"#{self.id}/" + new_file_name_with_type
image_path = "/images/"+"#{self.id}/" + new_file_name_with_type
full_orginal_path = (orginal_path + image_path)
if File.exists?(resize_path)
 return image_path
else
image = ImageList.new(orginal_path).resize(width,height).write(resize_path)
 return image_path
end
end

end
