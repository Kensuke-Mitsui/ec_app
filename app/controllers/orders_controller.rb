class OrdersController < ApplicationController
  before_action :set_product 
  # before_action :set_address
  
  require 'payjp' #APIキーを取得できる様に許可。
  
  def index
    # ユーザー登録が完了していない場合、登録画面に飛ばす。
    if user_signed_in?
      # ↓ActiveRecord_Relationについて調べる。なぜwhereではいけないのか？
      # @creditcard = CreditCard.where(user_id: current_user.id)
      @address = Address.find_by(user_id: current_user.id)
      @creditcard = CreditCard.find_by(user_id: current_user.id)
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@creditcard.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@creditcard.card_id)
    else
      redirect_to controller: "users/registrations", action: "new"
    end
  end

  def pay
    @creditcard = CreditCard.find_by(user_id: current_user.id)
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
      amount: @product.price,
      customer: @creditcard.customer_id,
      currency: 'jpy',
    )
  redirect_to action: 'done'
  end

  def done
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  # def set_address
  #   @address = Address.find_by(user_id: current_user.id)
  # end

end

