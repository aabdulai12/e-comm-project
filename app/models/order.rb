class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer, optional: true
  belongs_to :status
  belongs_to :user, optional: true
  belongs_to :province

  # Validations
  validates :status_id, presence: true
  validates :order_total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :gst_rate, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }
  validates :hst_rate, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }
  validates :pst_rate, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }

  # Callback to calculate order total and ensure province is set
  before_validation :calculate_totals_and_set_defaults, on: :create

  def calculate_taxes
    return {} unless province

    gst_rate = province.gst || 0
    pst_rate = province.pst || 0
    hst_rate = province.hst || 0

    subtotal = order_items.sum { |item| item.quantity * item.price }

    gst = subtotal * gst_rate
    pst = subtotal * pst_rate
    hst = subtotal * hst_rate

    total = subtotal + gst + pst + hst

    { subtotal: subtotal, gst: gst, pst: pst, hst: hst, total: total }
  end

  private

  def calculate_totals_and_set_defaults
    return unless province

    totals = calculate_taxes
    self.order_total = totals[:total]
  end
end
