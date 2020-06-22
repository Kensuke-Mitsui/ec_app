class ProductsController < ApplicationController
  def index  
    # @products = Product.all
    #productモデルに紐ずいたimageモデルの画像を引っ張る。
    # @products = Product.includes(:images).order('created_at DESC')
    # @products = Product.all.includes(:images).order('created_at DESC')
    @products = Product.all.order(created_at: :desc)
  end

  def new
    @product = Product.new
    @product.images.build
  end


  def create
    @product = Product.new(product_params)
    if @product.valid?
      @product.save
      redirect_to root_path, notice: '作成に成功'
    else
      # flash.now[:alert] = @product.errors.full_messages
      flash[:error] = '作成に失敗'
      redirect_to  new_product_path
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :unit, images_attributes: [:image, :item_id])
  end
end

