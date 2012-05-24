class LoansController < ApplicationController
  # GET /loans
  # GET /loans.json
  def index
    @completed = params[:completed]
    if @completed == "show"
      @loans = current_user.loans.where(:archived => true)
    else
      @loans = current_user.loans.where(:archived => false)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @loans }
    end
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    @loan = Loan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @loan }
    end
  end

  # GET /loans/new
  # GET /loans/new.json
  def new
    @loan = Loan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @loan }
    end
  end

  # GET /loans/1/edit
  def edit
    @loan = Loan.find(params[:id])
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(params[:loan])
    @loan.user = current_user

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        format.json { render json: @loan, status: :created, location: @loan }
      else
        format.html { render action: "new" }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /loans/1
  # PUT /loans/1.json
  def update
    @loan = Loan.find(params[:id])

    respond_to do |format|
      if @loan.update_attributes(params[:loan])
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan = Loan.find(params[:id])
    @loan.destroy

    respond_to do |format|
      format.html { redirect_to loans_url }
      format.json { head :no_content }
    end
  end

  def create_payment_plan
    @loan = Loan.find(params[:loan_id])
    @month = params[:month].to_i
    @payday = params[:payday]

    @dateparams = @payday.split("/")
    firstday = Date.new(@dateparams[2].to_i, @dateparams[1].to_i, @dateparams[0].to_i)

    @loan.create_payments(@month, firstday)
    LoanMailer.payment_plan(@loan).deliver
    redirect_to @loan, notice: "odeme plani bilgileri: #{@month} ay, #{@payday} ilk odemesi"
  end

  def archive
    @loan = Loan.find(params[:loan_id])

    if @loan.payments.count > 0 && @loan.remaining < 10 #10 must fixed, payment calculation based on integers...
      @loan.archived = true
      @loan.save
      redirect_to loans_path, notice: "borcu kapattiniz, gozunuz aydin :)"
    else
      redirect_to @loan, alert: "borcu kapatabilmeniz icin tum taksitlerin odenmesi gerekmektedir. Taksitlendirme yapmadiysaniz odeme plani olusturunuz"
    end
  end
end
