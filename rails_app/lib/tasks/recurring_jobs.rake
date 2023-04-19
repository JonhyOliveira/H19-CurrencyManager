namespace :recurring do
    task init: :environment do
        SendNewsletter.schedule!
    end
end