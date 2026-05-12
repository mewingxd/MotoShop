class Api::SalesController < ApplicationController
  before_action :authenticate_request

  def index
    sales = Sale.includes(:sale_items).order(created_at: :desc)
    sales = sales.where("DATE(date) = ?", params[:date]) if params[:date].present?
    render json: sales.as_json(include: :sale_items)
  end

  def create
    ActiveRecord::Base.transaction do
      sale = Sale.new(sale_params.except(:items))
      sale.date ||= Time.current
      sale.save!

      params[:items]&.each do |item|
        sale.sale_items.create!(
          product_id: item[:productId],
          name: item[:name],
          price: item[:price],
          quantity: item[:quantity],
          image_url: item[:image_url]
        )
        product = Product.find(item[:productId])
        product.decrement!(:stock, item[:quantity].to_i)
      end

      render json: sale.as_json(include: :sale_items), status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  private

  def sale_params
    params.permit(:client_id, :client_name, :subtotal, :tax, :total, :user_id, :date, items: {})
  end
end
