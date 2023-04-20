# frozen_string_literal: true

class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :currency_followings, dependent: :destroy
  has_many :followed_currencies, through: :currency_followings, class_name: "Currency", foreign_key: :currency_id

  belongs_to :favorite_currency, class_name: "Currency", foreign_key: :favorite_currency_id, optional: true

end
