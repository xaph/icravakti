class Loan < ActiveRecord::Base
  #associations
  belongs_to :user
  belongs_to :borrower
  has_many :payments
  attr_accessible :borrower_id, :description, :paid_value, :user_id, :value

  validates_presence_of :borrower_id, :value

  def name
    "##{id} #{borrower.name} - #{value}"
  end

  def update_paid
    @payments = self.payments
    self.paid_value = 0
    @payments.each { |payment|
      self.paid_value += payment.payment_value if payment.paid
      logger.info "odenen tutar: #{self.paid_value}"
    }
    self.save
  end

  def create_payments(month, payday)
    month.times {
      payment = Payment.new
      payment.payment_value = self.value/month
      payment.payment_date = payday
      payment.loan = self
      payment.save
      payday = payday.next_month
    }
  end

  def remaining
    value - paid_value
  end
end
