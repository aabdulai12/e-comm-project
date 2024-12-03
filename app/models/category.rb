class Category < ApplicationRecord
  has_and_belongs_to_many :products

  validates :title, presence: true
  validates :description, presence: true

  # attr_accessible :description, :title
end
