class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.integer :price
      t.integer :expiration
      t.integer :max_amount
      t.integer :coverage_percent
      t.integer :deductible
      t.integer :external_id
      t.string :provider
      t.string :description
      t.string :category

      t.timestamps
    end
  end
end
