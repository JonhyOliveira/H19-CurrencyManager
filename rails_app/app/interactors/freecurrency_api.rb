# frozen_string_literal: true
#
# Although different REST API's data access policies follow the same principles,
# their interfaces are very heterogeneous.
# This interactor facilitates the interaction with FreecurrencyAPI's REST API
#
class FreecurrencyApi
  include Interactor

  @@conn = Faraday.new "https://api.freecurrencyapi.com/v1/" do |c|
    c.response :json
    c.adapter :net_http
    c.headers = { apikey: Rails.application.credentials.config[:free_currency][:API_key] }
  end

  def call
    response = @@conn.get context.endpoint do | req |
      req.params = context.options if defined? context.options
    end

    puts response.success?
    if response.success?
      context.data = response.body["data"]
    elsif reponse.body.is_a? Hash
      # if possible, the provider will tells us what's wrong with the following format: { "message": "woopsie :D" }
      # since we can't use I18n to translate we should just send back the literal error message
      context.fail!(literal: response.body["message"])
    else
      context.fail!(message: "freecurrency.API_failure")
    end
  end
end
