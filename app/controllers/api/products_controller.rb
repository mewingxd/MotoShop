class Api::ProductsController < ApplicationController
  before_action :authenticate_request
  before_action :set_product, only: %i[show update destroy]

  def index
    products = Product.includes(:category).all
    render json: products.as_json(include: { category: { only: %i[id name] } })
  end

  def show
    render json: @product.as_json(include: { category: { only: %i[id name] } })
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name, :sku, :price_purchase, :price_buy, :stock, :stock_min,
      :refill, :description, :image_url, :category_id
    )
  end
end
