class Membership < ActiveRecord::Base
  belongs_to :list
  belongs_to :person, foreign_key: :person_email, primary_key: :email
  has_many :notes, dependent: :destroy
  has_many :metas, dependent: :destroy

  delegate :name, :email, to: :person

  validates :person_email, uniqueness: { scope: :list_id }

  accepts_nested_attributes_for :person
  accepts_nested_attributes_for :metas, :reject_if => lambda { |m| m[:key].blank? }
  accepts_nested_attributes_for :notes, :reject_if => lambda { |c| c[:content].blank? }

  def meta_data
    metas.all.map {|m| [m.key, m.value ]}.to_h
  end

  def meta_data= hashy
    hashy.map {|v, k| {key: k, value: v} }.each {|v| metas += [metas.build(v)] }
  end
end
