class SettingsController < ApplicationController
  before_action :square, only: [:create]
  
  def index
    @cards = current_user.cards.all
  end

  def show
  end
  
  def create
    card_nonce = params[:nonce]
    if current_user.square_customer_id.nil?
      api = SquareConnect::CustomersApi.new
      customer = api.create_customer({
        email_address: current_user.email
      }).to_hash[:customer]
      current_user.update_attribute :square_customer_id, customer[:id]
    end
    
    api = SquareConnect::CustomersApi.new
    card = api.create_customer_card(current_user.square_customer_id, {
      card_nonce: card_nonce
    }).to_hash[:card]
    
    current_user.cards.create(
      nonce: card[:id],
      last4: params[:last_4],
      brand: params[:card_brand],
      exp_month: params[:exp_month],
      exp_year: params[:exp_year]
    )
    redirect_to settings_path
  end
end
