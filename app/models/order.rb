class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer, optional: true
  belongs_to :status
  belongs_to :user, optional: true
  belongs_to :province

  # Callbacks
  before_validation :set_default_status, on: :create
  before_validation :calculate_totals, on: :create

  # Validations
  validates :status_id, presence: true
  validates :order_total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :gst_rate, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }
  validates :hst_rate, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }
  validates :pst_rate, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }

  # Calculate taxes and totals
  def calculate_taxes
    gst_rate = province&.gst || 0
    pst_rate = province&.pst || 0
    hst_rate = province&.hst || 0

    subtotal = order_items.sum { |item| item.quantity * item.price }
    gst = subtotal * gst_rate
    pst = subtotal * pst_rate
    hst = subtotal * hst_rate
    total = subtotal + gst + pst + hst

    { subtotal: subtotal, gst: gst, pst: pst, hst: hst, total: total }
  end

  private

  def set_default_status
  self.status ||= Status.find_or_create_by(title: "pending")
  Rails.logger.debug "Default status set: #{self.status&.title}"
end

  def calculate_totals
    # Calculate and set order total
    tax_data = calculate_taxes
    self.gst_rate ||= tax_data[:gst]
    self.pst_rate ||= tax_data[:pst]
    self.hst_rate ||= tax_data[:hst]
    self.order_total ||= tax_data[:total]
  end
end
