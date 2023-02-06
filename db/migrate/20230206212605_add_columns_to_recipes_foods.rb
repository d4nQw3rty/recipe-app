class AddColumnsToRecipesFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes_foods, :quantity, :integer
  end
end
