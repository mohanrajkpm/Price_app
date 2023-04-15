class ReportStatus
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(price)
        p price
        price = converted_price(price)
        Alert.where(status: 'created').each do |alert|
            alert_price = converted_price(alert.price)
            if alert_price == price
                alert.update(status: 'triggered')
                send_mail_alert(alert)
            end
        end
    end

    private

    def converted_price(price)
        price = "%.3f" % price
        price.to_f
    end

    def send_mail_alert(alert)
        PriceMailer.with(alert: alert).new_price_email.deliver_later
    end
end