class AddColumnToChef < ActiveRecord::Migration
  def change
    add_column :chefs, :description, :string
  end
end
