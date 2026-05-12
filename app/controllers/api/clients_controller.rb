class Api::ClientsController < ApplicationController
  before_action :authenticate_request

  def index
    render json: Client.all
  end

  def create
    client = Client.new(name: params[:name])
    if client.save
      render json: client, status: :created
    else
      render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
