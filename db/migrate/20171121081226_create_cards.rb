class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :last4
      t.string :exp_year
      t.string :exp_month
      t.string :brand
      t.string :nonce
      t.integer :user_id
      t.boolean :default_flag
      t.timestamps
    end
  end
end
