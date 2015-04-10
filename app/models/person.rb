class Person < ActiveRecord::Base
  validates :email, presence: true
  has_many :memberships, foreign_key: :person_email, primary_key: :email
  has_many :notes, through: :memberships
end
