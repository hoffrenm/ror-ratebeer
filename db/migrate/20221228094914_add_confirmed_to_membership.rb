class AddConfirmedToMembership < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :confirmed, :boolean

    Membership.all.each do 
      |member| member.update_attribute(:confirmed, true) 
    end
  end
end
