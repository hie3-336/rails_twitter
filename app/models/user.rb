# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: %i[github]
  validates :name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :birthday, presence: true

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  has_many :tweets, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.telephone_number = '08000000000'
      user.date_of_birth = '1993-01-01'

      if user.persisted? || auth.provider == 'github'
        user.skip_confirmation! if auth.provider == 'github'
        user.save
      end
    end
  end
  

  def self.create_unique_string
    SecureRandom.uuid
  end

end
