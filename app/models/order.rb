class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy # Ensures associated items are deleted when the order is deleted
  belongs_to :customer, optional: true
  belongs_to :status
  belongs_to :user, optional: true
  has_many :line_items
  belongs_to :province
  has_many :line_items

  validates :status_id,   :presence => true
  validates :order_total, :presence => true,
                          :numericality => { :greater_than_or_equal_to => 0 }

  validates :gst_rate,    :allow_nil => true,
                          :numericality => { :greater_than_or_equal_to => 0 }
  
  validates :hst_rate,    :allow_nil => true,
                          :numericality => { :greater_than_or_equal_to => 0 }
 
  validates :pst_rate,    :allow_nil => true,
                          :numericality => { :greater_than_or_equal_to => 0 }        

  validates :order_total, presence: true, numericality: true


  #attr_accessible :gst_rate, :hst_rate, :pst_rate, :status_id, :order_total, :customer_id
end
