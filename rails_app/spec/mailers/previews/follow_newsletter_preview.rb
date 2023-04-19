# Preview all emails at http://localhost:3000/rails/mailers/follow_newsletter
class FollowNewsletterPreview < ActionMailer::Preview

    def summary
        FollowNewsletterMailer.with(user: User.first, descriptive: "followed").summary
    end

end
