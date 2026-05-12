class Api::AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id, role: user.role, email: user.email })
      render json: {
        token: token,
        role: user.role,
        userEmail: user.email,
        userName: user.name
      }
    else
      render json: { error: "Credenciales inválidas" }, status: :unauthorized
    end
  end
end
