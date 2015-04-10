class Membership < ActiveRecord::Base
  belongs_to :list
  belongs_to :person, foreign_key: :person_email, primary_key: :email
  has_many :notes

  delegate :name, :email, to: :person

  validates :person_email, uniqueness: { scope: :list_id }

  accepts_nested_attributes_for :person
  accepts_nested_attributes_for :notes, :reject_if => lambda { |c| c[:content].blank? }
end
