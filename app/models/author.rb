class Author < ActiveRecord::Base
has_many :article_authors
has_many :articles , :through=>:article_authors
end
