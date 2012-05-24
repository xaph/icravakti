require 'test_helper'

class LoanMailerTest < ActionMailer::TestCase
  test "payment_plan" do
    mail = LoanMailer.payment_plan
    assert_equal "Payment plan", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
