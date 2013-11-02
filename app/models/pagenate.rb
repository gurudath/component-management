class Pagenate < ActiveRecord::Base
   paginate_alphabetically :by => :first_name
end
