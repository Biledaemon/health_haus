class AddBudgetToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :budget, :float
  end
end
