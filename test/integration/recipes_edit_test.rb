require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  end

  def setup
    @recipe = Recipe.new(name: "vegetable", description: "great vegetable recipe")  
  end

  test "reject invalid recipe update" do
  get edit_recipe_path(@recipe)
  assert_template 'recipes/edit'
  patch recipe_path(@recipe), params: { recipe: { name: " ", 

                                               description: "some description" } } 
  assert_template 'recipes/edit'
  assert_select 'h2.panel-title'
  assert_select 'div.panel-body'
 end


test "should get recipes show" do
  get recipe_path(@recipe)
  assert_template 'recipes/show'
  assert_match @recipe.name, response.body
  assert_match @recipe.description, response.body
  assert_match @chef.chefname, response.body
  assert_select 'a[href=?]', edit_recipe_path(@recipe), text: "Edit this recipe"
  assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"
  assert_select 'a[href=?]', recipes_path, text: "Return to recipes listing"
end


  
end
