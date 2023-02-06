class AddColumnsToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :name, :string
    add_column :recipes, :preparation_time, :string
    add_column :recipes, :cooking_time, :string
    add_column :recipes, :description, :text
    add_column :recipes, :public, :boolean
  end
end
