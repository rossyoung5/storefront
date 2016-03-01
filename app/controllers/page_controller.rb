class PageController < ApplicationController
  def home
  end

  def index
    if params[:search]
      @products=Product.search_by_name_or_desc(params[:search])
      if @products.empty?
        flash.now[:notice] = "No result found for \"#{params[:search]}\", here's the rest of our products."
        @products=Product.all
      end
    elsif params[:category_id]
      @category=Category.find(params[:category_id])
      @products=Product.where(category_id: @category.id)
    else
    @products = Product.all
    end
  end

  def about
  end

end