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
end