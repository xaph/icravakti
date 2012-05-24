class Borrower < ActiveRecord::Base
  #associations
  has_many :loans
  belongs_to :user
  attr_accessible :facebook_name, :info, :name, :twitter_name, :email

  validates_presence_of :name, :email
end
