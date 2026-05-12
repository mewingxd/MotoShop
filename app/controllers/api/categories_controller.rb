class Api::CategoriesController < ApplicationController
  before_action :authenticate_request

  def index
    render json: Category.all
  end

  def create
    category = Category.new(name: params[:name])
    if category.save
      render json: category, status: :created
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    head :no_content
  end
end
