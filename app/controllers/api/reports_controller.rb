class Api::ReportsController < ApplicationController
  before_action :authenticate_request

  def weekly_sales
    start_date = 6.days.ago.beginning_of_day
    sales = Sale.where(date: start_date..Time.current)
      .group("DATE(date)")
      .sum(:total)
    render json: sales
  end

  def top_products
    top = SaleItem.joins(:product)
      .group("products.name")
      .sum(:quantity)
      .sort_by { |_, v| -v }
      .first(10)
    render json: top.map { |name, qty| { name: name, quantity: qty } }
  end

  def daily_sales
    today_sales = Sale.where("DATE(date) = ?", Date.today)
      .includes(:sale_items)
    render json: today_sales.as_json(include: :sale_items)
  end

  def services_summary
    services = Service.group(:service_type).count
    render json: services.map { |type, count| { name: type, count: count } }
  end
end
