class AddActivityToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :active, :boolean

    User.all.each do |user|
      user.update_attribute(:active, true)
    end
  end
end
