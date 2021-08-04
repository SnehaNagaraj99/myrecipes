require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @recipe = Recipe.new(name: "vegetable", description: "great vegetable recipe")  
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end  
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "description shouldn't be less than 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end
  
  test "description shouldn't be more than 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end

  test "reject invalid recipe submissions" do
  get new_recipe_path
  assert_template 'recipes/new'
  assert_no_difference 'Recipe.count' do
    post recipes_path, params: { recipe: { name: " ", description: " " } }
  end
  assert_template 'recipes/new'
  assert_select 'h2.panel-title'
  assert_select 'div.panel-body'
  end

  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "chicken saute"
    description_of_recipe = "add chicken, add vegetables,cook for 20 minutes, serve delicious meal"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { name: name_of_recipe, description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end
end