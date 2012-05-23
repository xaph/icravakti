class UserController < ApplicationController
  skip_before_filter :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end

  def twitter_signup
    @user = User.new
    @user.provider = session["devise.twitter_data"].provider
    @user.uid = session["devise.twitter_data"].uid
    pass = Devise.friendly_token[0,20]
    @user.password = pass
    @user.password_confirmation = pass
  end
end
