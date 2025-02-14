class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    # Expect the token in the Authorization header, e.g., "Bearer <token>"
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?

    if token
      decoded = JsonWebToken.decode(token)
      @current_user = User.find_by(id: decoded[:user_id]) if decoded
    end

    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  rescue
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end


