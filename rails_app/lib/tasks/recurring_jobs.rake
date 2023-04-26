# frozen_string_literal: true
namespace :recurring do
  task init: :environment do
    SendNewsletter.schedule!
  end
end
