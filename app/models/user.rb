class User < ActiveRecord::Base
  def self.create_from_omniauth(params)
    attributes = {
      email: params['info']['email'],
      password: Devise.friendly_token
    }

    create(attributes)
  end

  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter, :linkedin, :google_oauth2, :instagram]

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     user.name = auth.info.name
  #     user.image = auth.info.image
  #   end
  # end

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end
end