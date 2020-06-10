# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end 
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.addresses.build
    render :new_address 

  end

  def new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.addresses.build(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
    redirect_to creditcards_path #クレジットカード登録のnewアクションへ飛ばす
  end

  def new_credit_card
    card = CreditCard.where(user_id: current_user.id)
    #クレジットカードのuser_idカラムへログイン中のユーザーのidが入ったハッシュを,cardに代入。
  end

  require "payjp" #APIキーを取得できる様に許可。

  def pay
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] #payjpから送られてくる値を取得するために、秘密鍵で認証しています。
    if params['payjpToken'].blank? 
      render :new_credit_card #JSで作成したpayjpTokenがからの場合、やり直し。
    else
      customer = Payjp::Customer.create(card: params['payjpToken'],) #customer変数に取得した値を代入しています。
      @creditcard = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @creditcard.save
        redirect_to root_path
      else
        redirect_to action: "new_credit_card"
      end
      # @creditcard.save
      # @creditcard = CreditCard.new(credit_card_params)
      # @creditcard = Creditcard.new(customer_id: customer.id, card_id: customer.default_card)
      # @creditcard = CreditCard.new(:customer_id)
      # @creditcard = CreditCard.new(:customer_id)
      # @creditcard[:customer_id] = customer.id
      # @creditcard[:card_id] = customer.default_card
      # unless @creditcard.valid?
      #   flash.now[:alert] = @creditcard.errors.full_messages
      #   render :new_credit_card and return
      # end
      # @user.credit_cards.build(customer_id: customer.id, card_id: customer.default_card)
    end
  end

  private

  def address_params
    params.require(:address).permit(:post_code, :prefecture, :city, :block, :building, :phone_number, :destination_family_name, :destination_first_name, :destination_family_name_kana, :destination_first_name_kana)
  end

  # def credit_card_params
  #   params.permit(:user_id, :customer_id, :card_id,)
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
