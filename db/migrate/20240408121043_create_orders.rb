# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :user_name, null: false
      t.string :email, null: false
      t.string :address_line1, null: false
      t.string :address_line2, null: false
      t.string :cardholder_name, null: false
      t.string :card_number, null: false
      t.string :expiration_date, null: false
      t.string :security_code, null: false

      t.timestamps
    end
  end
end
