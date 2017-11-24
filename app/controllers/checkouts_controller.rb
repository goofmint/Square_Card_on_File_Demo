class CheckoutsController < ApplicationController
  before_action :square, only: [:create]
  
  def index
  end
  
  def create
    idempotency_key = SecureRandom.uuid
    card = current_user.cards.find(params[:checkout][:card])
    amount = params[:checkout][:amount].to_i
    
    api = SquareConnect::TransactionsApi.new
    transaction = api.charge(load_config['location_id'], {
      idempotency_key: idempotency_key,
      amount_money: {
        amount: amount, currency: 'JPY'
      },
      customer_id: current_user.square_customer_id,
      customer_card_id: card.nonce
    }).to_hash[:transaction]
    redirect_to checkout_path(transaction[:id])
  end
  
  def show
    @transaction_id = params[:id]
  end
end
