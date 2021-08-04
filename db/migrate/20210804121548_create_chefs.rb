class CreateChefs < ActiveRecord::Migration
  def up
    drop_table :chefs
    # create_table :chefs do |t|
    #   t.string :chefname
    #   t.text :email
    #   t.timestamps
    # end
  end
end
