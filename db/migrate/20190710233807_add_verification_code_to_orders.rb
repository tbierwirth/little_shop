class AddVerificationCodeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :verification_code, :string
  end
end
