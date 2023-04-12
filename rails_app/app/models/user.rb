# frozen_string_literal: true

class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :currency_followings, primary_key: :email, foreign_key: :follower_email, dependent: :destroy
  has_many :followed_currencies, through: :currency_followings, class_name: "Currency"

  belongs_to :favorite_currency, class_name: "Currency", foreign_key: :favorite_currency_code, optional: true

end
