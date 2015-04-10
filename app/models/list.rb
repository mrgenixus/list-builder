class List < ActiveRecord::Base
  has_many :memberships
  has_many :people, through: :memberships, foreign_key: :person_email, primary_key: :email

  accepts_nested_attributes_for :people
end
