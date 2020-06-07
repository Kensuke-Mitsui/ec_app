class CreditCardController < ApplicationController

  require "payjp"
  before_action :set_card,only: [:delete, :show]

  def new
    card = CreditCard.where(user_id: current_user.id)
    # redirect_to action: "show" if card.exists?
  end

  def pay #payjpとCardのデータベース作成。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjpToken'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjpToken'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to root_path
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete
    if @card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      redirect_to action: "new"
    end
  end


  def show #Cardのデータpayjpに送り情報を取り出します
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end


  def set_card
    @card = CreditCard.where(user_id: current_user.id).first
  end
end

