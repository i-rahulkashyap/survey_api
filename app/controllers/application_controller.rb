class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?

    if token
      decoded = JsonWebToken.decode(token)
      @current_user = User.find_by(id: decoded[:user_id]) if decoded
      Rails.logger.info "Decoded token: #{decoded}" if decoded
    end

    unless @current_user
      Rails.logger.warn "Authentication failed: Invalid token or user not found"
      render json: { error: 'Not Authorized 1' }, status: :unauthorized
    end
  rescue => e
    Rails.logger.error "Authentication error: #{e.message}"
    render json: { error: 'Not Authorized 2' }, status: :unauthorized
  end
end