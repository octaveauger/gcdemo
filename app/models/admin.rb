class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    admin = Admin.where(:email => data["email"]).first
    unless admin
      admin = Admin.create(email: data["email"],
        password: Devise.friendly_token[0,20],
        provider: access_token.provider,
        uid: access_token.uid,
      )
    end
    admin
  end
end
