class ImageProperty < ActiveRecord::Base
 belongs_to :entity, :polymorphic => true
 belongs_to :image
end
