class Payment < ActiveRecord::Base
  after_save :update_loan_value
  after_update :update_loan_value
  after_destroy :update_loan_value
  #associations
  belongs_to :loan
  attr_accessible :loan_id, :paid, :payment_date, :payment_value

  private
  def update_loan_value
    if self.paid
      @loan = self.loan
      @loan.update_paid
    end
  end
end
