class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid
  # attr_accessible :title, :body

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    provider = access_token.provider
    data = access_token.extra.raw_info
    if user = self.find_by_provider_and_uid(provider, data.id)
      user
    else # Create a user with a stub password. 
      self.create(:email => data.email, :password => Devise.friendly_token[0,20], :provider => provider, :uid => data.id) 
    end
  end

  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    provider = access_token.provider
    logger.info "provider is #{provider}"
    data = access_token.extra.raw_info
    logger.info "uid is #{data.id}"
    if user = self.find_by_provider_and_uid(provider, data.id)
      user
    else # Create a user with a stub password. 
      user = User.new
    end
  end
end
