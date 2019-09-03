class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]

  # validations
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format:{with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "is badly formatted"}

  # associations
  has_many :paintings
  belongs_to :role

  # callbacks
  validate  :check_for_duplicate_admin, on: :create

  def check_for_duplicate_admin
    user_present = User.find_by(role_id: self.role_id) && Role.find_by(id: self.role_id).try(:name) == "Admin"

    if user_present
      errors.add(:base,"Admin is already present, There can be only one admin!!")
      return false
    else
      return true
    end
  end

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
