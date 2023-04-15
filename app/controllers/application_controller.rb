class ApplicationController < ActionController::API
    include Paginable

    def not_found
        render json: { error: 'not_found' }
    end

    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            if @decoded.present?
                @current_user = User.find(@decoded[:user_id])
            else
                @current_user = User.find(@decoded.to_i)
            end
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: 'Please try to login again!' }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end
end
