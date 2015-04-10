class ChangePrimaryKeysForMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :person_email, :string

    update_ids = Membership.all.map(&:id)

    update_values = Membership.all.map do |membership|
      {
        person_email: Person.find(membership.person_id).email
      }
    end

    Membership.update(update_ids, update_values);

    remove_column :memberships, :person_id
  end
end
