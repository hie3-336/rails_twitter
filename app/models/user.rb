# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: %i[github]
  validates :name, presence: true,
                   format: { with: /\A[a-zA-Z0-9_-]+\z/ },
                   length: { minimum: 3, maximum: 25 }

  validates :email, presence: true
  validates :phone_number, presence: true
  validates :birthday, presence: true

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  has_many :tweets, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_mane :timelines, dependent: :destroy

  has_many :active_relationships, class_name: 'Follower', foreign_key: 'follower_id', dependent: :destroy, inverse_of: 'followed'
  has_many :passive_relationships, class_name: 'Follower', foreign_key: 'followed_id', dependent: :destroy, inverse_of: 'follower'

  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # プロフィール画像
  has_one_attached :avater_image
  has_one_attached :profile_image

  def to_param
    name
  end

  def self.from_omniauth(auth)
    find_or_create_by!(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.phone_number = '08000000000'
      user.birthday = '1993-01-01'

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
