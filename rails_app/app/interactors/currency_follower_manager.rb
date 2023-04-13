# frozen_string_literal: true
class CurrencyFollowerManager
  include Interactor

  #
  # This interactor facilitates the process of a user following/unfollowing a currency
  #
  # @param [Context] context Hash that describes the context of the operation.
  #		The format for a valid execution is the following:
  #		{ user: User, currency: Currency, follow: [true/false || true] }
  #
  # @return [Context] context describes the result of the operation
  #
  def call
    user = context.user
    currency = context.currency

    # default is to establish association
    follow = context.follow != nil ? context.follow : true

    unless user.is_a?(User) && currency.is_a?(Currency)
      context.fail! message: "currencyfollower.invalid_context"
      return
    end

    association_params = { follower: user, followed_currency: currency }

    if follow
      following = CurrencyFollowing.new association_params
      
      # this could be changed if multiple user types are needed (premium, etc.)
      follow_limit = 50 

      context.fail! message: "currencyfollower.user_follow_limit_reached" unless CurrencyFollowing.where(follower: user).count < follow_limit

      context.fail! message: "currencyfollower.already_exists" unless following.save
    else
      followings = CurrencyFollowing.where association_params

      if followings.any?
        followings.destroy_all
      else
        context.fail! message: "currencyfollower.not_found"
      end
    end
  end
end
