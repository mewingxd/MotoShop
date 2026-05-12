class Api::ServicesController < ApplicationController
  before_action :authenticate_request
  before_action :set_service, only: %i[show update destroy]

  def index
    services = Service.includes(:mechanic, :service_products).order(created_at: :desc)
    render json: services.as_json(include: { mechanic: { only: %i[id full_name] }, service_products: {} })
  end

  def show
    render json: @service.as_json(include: { mechanic: { only: %i[id full_name] }, service_products: {} })
  end

  def create
    ActiveRecord::Base.transaction do
      service = Service.new(service_params.except(:products))
      service.save!

      params[:products]&.each do |p|
        service.service_products.create!(product_id: p[:productId], quantity: p[:quantity])
        Product.find(p[:productId]).decrement!(:stock, p[:quantity].to_i)
      end

      render json: service, status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  def update
    ActiveRecord::Base.transaction do
      @service.update!(service_params.except(:products))

      if params[:products]
        @service.service_products.destroy_all
        params[:products].each do |p|
          @service.service_products.create!(product_id: p[:productId], quantity: p[:quantity])
        end
      end

      render json: @service
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  def destroy
    @service.destroy
    head :no_content
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.permit(
      :client_name, :mechanic_id, :service_type,
      :motorcycle_brand, :motorcycle_model, :motorcycle_year, :motorcycle_plates,
      :problem_description, :service_cost, :total_cost, :status, :end_date
    )
  end
end
