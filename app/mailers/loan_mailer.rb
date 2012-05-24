class LoanMailer < ActionMailer::Base
  default from: "mzcakmak@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.loan_mailer.payment_plan.subject
  #
  def payment_plan(loan)
    @payments = loan.payments
    logger.info "payments count #{@payments.count}"

    mail to: loan.borrower.email, subject: "Bana olan borclarinin vadesi"
  end
end
