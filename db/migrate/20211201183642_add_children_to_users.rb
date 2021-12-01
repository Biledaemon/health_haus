class AddChildrenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :children, :integer
  end
end
