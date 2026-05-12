class Api::MovementsController < ApplicationController
  before_action :authenticate_request

  def index
    date = params[:date]

    sales_query = Sale.all
    services_query = Service.all
    purchases_query = Purchase.all

    if date.present?
      sales_query = sales_query.where("DATE(date) = ?", date)
      services_query = services_query.where("DATE(created_at) = ?", date)
      purchases_query = purchases_query.where("DATE(date) = ?", date)
    end

    sales = sales_query.map do |s|
      { type: "venta", id: s.id, description: s.client_name, amount: s.total, date: s.date || s.created_at }
    end

    services = services_query.where(status: "finished").map do |sv|
      { type: "servicio", id: sv.id, description: sv.client_name, amount: sv.total_cost, date: sv.end_date || sv.created_at }
    end

    purchases = purchases_query.map do |p|
      { type: "compra", id: p.id, description: "Compra ##{p.id}", amount: -p.total_price.to_f, date: p.date || p.created_at }
    end

    movements = (sales + services + purchases).sort_by { |m| m[:date] }.reverse
    render json: movements
  end
end
