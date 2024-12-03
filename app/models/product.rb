class Product < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :category
  has_and_belongs_to_many :categories

  validates :name,           presence: true
  validates :description,    presence: true
  validates :price,          presence:     true,
                             numericality: { greater_than_or_equal_to: 0 }

  validates :sale_price,     allow_nil:    true,
                             numericality: { greater_than_or_equal_to: 0 }

  validates :stock_quantity, presence:     true,
                             numericality: { greater_than_or_equal_to: 0 }

  # validates :category,       :presence => true

  # attr_accessible :description, :name, :price, :sale_price, :stock_quantity, :category_id, :image

  # Scoped_Search requires you set the search variables here
  has_attached_file :image, styles:      { medium: "300x300>", thumb: "100x100>" },
                            default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: %r{\Aimage/.*\z} }
end
