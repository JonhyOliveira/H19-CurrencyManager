class SendNewsletter
  include Interactor
  include Delayed::RecurringJob

  run_every 1.week
  run_at '9:00am'
  timezone 'Europe/Lisbon'

  def perform
    self.call
  end

  def call
    User.all.each do |user|
      # send the weekly followed newsletter
      FollowNewsletterMailer.with(user: user, descriptive: "weekly followed").summary.deliver
    end
    
  end
end
