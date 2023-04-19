# frozen_string_literal: true
class FollowNewsletterMailer < ApplicationMailer

  before_action { @recipient, @descriptive = params[:user], params[:descriptive] }

  default to: -> { @recipient.email },
          from: "newsletter@example.com"

  def summary
    puts params
    user = @recipient
    @currencies = CurrencyFollowing.where(follower_email: user.email).map { |following| following.followed_currency }

    mail subject: "Your #{@descriptive} summary".squish
  end

end
