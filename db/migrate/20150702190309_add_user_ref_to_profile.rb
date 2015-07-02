class AddUserRefToProfile < ActiveRecord::Migration
  def change
    add_reference :profile, :user, index: true
  end
end
