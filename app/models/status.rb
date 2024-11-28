class Status < ActiveRecord::Base
 # attr_accessible :description, :title

  has_many :orders

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

end
