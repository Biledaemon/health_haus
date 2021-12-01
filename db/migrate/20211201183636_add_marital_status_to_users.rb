class AddMaritalStatusToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :marital_status, :string
  end
end
