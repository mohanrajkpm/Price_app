class PriceMailer < ApplicationMailer
    def new_price_email
        @alert = params[:alert]
        @alert_price = @alert.price.to_f
        mail(to: @alert.user.email, subject: "Your price reached stock market!  : #{@alert_price}")
    end
end
