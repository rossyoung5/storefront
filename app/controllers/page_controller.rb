class PageController < ApplicationController
  def home
    @featured_products = Product.featured
  end

  def index
    if params[:search]
      @products=Product.search_by_name_or_desc(params[:search]).includes(:brand)
      if @products.empty?
        flash.now[:notice] = "No result found for \"#{params[:search]}\", here's the rest of our products."
        @products=Product.includes(:brand)
      end
    elsif params[:category_id]
      @category=Category.find(params[:category_id])
      @products=Product.where(category_id: @category.id).includes(:brand)
    else
    @products = Product.includes(:brand)
    end
  end

  def about
  end

end