class AddColumnsToFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :name, :string
    add_column :foods, :measurement_unit, :string
    add_column :foods, :price, :integer
    add_column :foods, :quantity, :integer
  end
end
