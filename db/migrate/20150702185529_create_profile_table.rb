class CreateProfileTable < ActiveRecord::Migration
  def change
    create_table :profile do |t|
      t.string :bio, limit: 100
    end
  end
end
