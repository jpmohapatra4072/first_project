class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(first_name: data['first_name'], last_name: data['last_name'],
        email: data['email'],
        password: Devise.friendly_token[0,20],
        provider: access_token["provider"],
        uid: access_token["uid"]
      )
    end

    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
