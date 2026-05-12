class Api::PurchasesController < ApplicationController
  before_action :authenticate_request

  def index
    purchases = Purchase.includes(:product).order(created_at: :desc)
    purchases = purchases.where("DATE(date) = ?", params[:date]) if params[:date].present?
    render json: purchases.as_json(include: { product: { only: %i[id name] } })
  end

  def create
    ActiveRecord::Base.transaction do
      purchase = Purchase.new(purchase_params)
      purchase.date ||= Time.current
      purchase.user_id = @current_user_id
      purchase.save!

      product = Product.find(purchase.product_id)
      product.increment!(:stock, purchase.quantity)

      render json: purchase, status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  private

  def purchase_params
    params.require(:purchase).permit(:product_id, :quantity, :total_price, :date)
  end
end
