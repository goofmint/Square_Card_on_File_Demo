class AddSquareCustomerIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :square_customer_id, :string
  end
end
