# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  validates :name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :birthday, presence: true

  # validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  has_many :tweets, dependent: :destroy
end
