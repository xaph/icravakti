class Loan < ActiveRecord::Base
  #associations
  belongs_to :user
  belongs_to :borrower
  attr_accessible :borrower_id, :description, :paid_value, :user_id, :value
end
