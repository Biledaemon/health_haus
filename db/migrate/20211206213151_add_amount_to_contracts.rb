class AddAmountToContracts < ActiveRecord::Migration[6.1]
  def change
    add_column :contracts, :amount, :integer
  end
end
