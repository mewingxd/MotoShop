class Api::MechanicsController < ApplicationController
  before_action :authenticate_request
  before_action :set_mechanic, only: %i[show update destroy]

  def index
    render json: Mechanic.all
  end

  def show
    services = @mechanic.services.order(created_at: :desc)
    render json: @mechanic.as_json.merge(services: services)
  end

  def create
    mechanic = Mechanic.new(mechanic_params)
    if mechanic.save
      render json: mechanic, status: :created
    else
      render json: { errors: mechanic.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @mechanic.update(mechanic_params)
      render json: @mechanic
    else
      render json: { errors: @mechanic.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @mechanic.destroy
    head :no_content
  end

  private

  def set_mechanic
    @mechanic = Mechanic.find(params[:id])
  end

  def mechanic_params
    params.require(:mechanic).permit(:full_name, :salary, :active)
  end
end
