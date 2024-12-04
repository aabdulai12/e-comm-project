class Customer < ApplicationRecord
  belongs_to :province
  belongs_to :province
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :address,    presence: true
  validates :city,       presence: true
  validates :email,      presence: true
  validates :postal_code, presence: true
  validates :province, presence: true
  validates :province_id, presence:     true,
                          numericality: true

 
end
