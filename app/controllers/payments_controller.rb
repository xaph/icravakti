class PaymentsController < ApplicationController
  before_filter :get_loan
  # GET /payments
  # GET /payments.json
  def index
    @payments = @loan.payments.order("loan_id")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment = @loan.payments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/new
  # GET /payments/new.json
  def new
    @payment = Payment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id])
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(params[:payment])
    @payment.loan = @loan

    respond_to do |format|
      if @payment.save
        format.html { redirect_to [@loan, @payment], notice: 'Payment was successfully created.' }
        format.json { render json: @payment, status: :created, location: @payment }
      else
        format.html { render action: "new" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # PUT /payments/1
  # PUT /payments/1.json
  def update
    @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(params[:payment])
        format.html { redirect_to [@loan, @payment], notice: 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to loan_payments_url(@loan) }
      format.json { head :no_content }
      format.js
    end
  end

  def toggle_paid
    @payment = @loan.payments.find(params[:payment_id])
    if @payment.paid
      @payment.paid = false
    else
      @payment.paid = true
    end
    @payment.save
    redirect_to @loan, notice: "odeme basariyla guncellendi"
  end

  def get_loan
    @loan = Loan.find(params[:loan_id])
  end
end
