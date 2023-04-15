class AlertsController < ApplicationController
    before_action :authorize_request

    # GET /alerts
    def index
        alerts = 
        if params[:filter].present? && params[:filter][:status].present?
            @current_user.alerts.where(status: params[:filter][:status])
        else
            @current_user.alerts
        end
        paginated = paginate(alerts)
        options = { meta: paginated.meta.to_h, links: paginated.links.to_h }
        render json: AlertSerializer.new(paginated.items, options), status: :ok
    end

    # POST /alerts
    def create
        @alert = Alert.new(alert_params)
        @alert.user = @current_user
        if @alert.save
          render json: AlertSerializer.new(@alert), status: :created
        else
          render json: { errors: @alert.errors.full_messages },
                 status: :unprocessable_entity
        end
    end

    # DELETE /alert
    def destroy
        @alert = Alert.find!(params[:id])
        @alert.destroy
    end

    private

    def alert_params
        params.permit(
            :price
        )
    end   
end