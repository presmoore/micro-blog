class CreatePostsTable < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :textfield, limit: 150
    end
  end
end
