class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :reactions, dependent: :destroy
  has_many :users, through: :reactions

  accepts_nested_attributes_for :categories, reject_if: :no_name_category

  validates :name, presence: true
  validates :price, presence: true
  validates :size, presence: true

  def count_with_kind(arg)
    number = self.reactions.where(kind: arg).count
    return "#{arg} - #{number}" # rubocop:disable Style/RedundantReturn
  end


  def find_kind_user_relation(user)
    self.reactions.find_by(user_id: user.id).kind
  end


  def no_name_category(attributes)
    attributes["name"].blank?
  end
end
