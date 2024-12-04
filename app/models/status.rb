class Status < ApplicationRecord
  # attr_accessible :description, :title

  has_many :orders, dependent: :destroy


  # VALIDATE TITLE ADDED
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
end
