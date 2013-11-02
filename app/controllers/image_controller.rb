class ImageController < ApplicationController

def list
 @images = Image.paginate(:page => params[:page], :per_page => 10)
end

def new
 render :template=>"/image/new"
end

 def create
 @image = Image.new(params[:image_form])
 @image.name=params[:image]["name"]
 @image.description=params[:image]["description"]
 @image.caption=params[:image]["caption"]
 @image.save 
 @image.save_image(params[:image_set])
 render :template=>"/image/thanks"
end

end
