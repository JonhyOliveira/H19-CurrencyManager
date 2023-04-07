class UnfollowCurrency
  include Interactor

  def call
    context.fail! message: 'currency.symbol.not_found' unless (@currency = Currency.find(context.symbol))

    context.fail! message: 'user.email.not_found' unless (@user = User.find(email: context.email))

    # TODO
  end
end
