class CreateArticleAuthors < ActiveRecord::Migration
  def change
    create_table :article_authors do |t|
      t.integer :article_id
      t.integer :author_id
      t.integer :sequence_number

      t.timestamps
    end
  end
end
