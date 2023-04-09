class CurrencyFollowerManager
	include Interactor
	
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
