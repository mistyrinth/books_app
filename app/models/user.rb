class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i(github)

  # ActiveRecord
  has_one_attached :image

  # omniauth
  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  def self.find_for_github_oauth(auth, signed_in_resource = nil)

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    unless user
    user = User.new(provider: auth.provider,
                    uid:      auth.uid,
                    name:     auth.info.name,
                    email:    User.dummy_email(auth),
                    password: Devise.friendly_token[0, 20]
    )
    end
    user.skip_confirmation!
    user.save
    user
  end
end
