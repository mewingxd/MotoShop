class ApplicationController < ActionController::API
  SECRET_KEY = Rails.application.secret_key_base

  def authenticate_request
    header = request.headers["Authorization"]
    token = header&.split(" ")&.last
    decoded = decode_token(token)
    @current_user_id = decoded&.dig(0, "user_id")
    @current_user_role = decoded&.dig(0, "role")
    render json: { error: "No autorizado" }, status: :unauthorized unless @current_user_id
  rescue JWT::DecodeError
    render json: { error: "Token inválido" }, status: :unauthorized
  end

  def encode_token(payload)
    JWT.encode(payload, SECRET_KEY, "HS256")
  end

  def decode_token(token)
    JWT.decode(token, SECRET_KEY, true, { algorithm: "HS256" }) if token
  end
end
