require "test_helper"

class RecipeTest < ActiveSupport::TestCase
   
    def setup
      @chef = Chef.create(chefname: "Bob", email: "bob@example.com")
      @recipe = @chef.recipes.build(name: "Chicken Curry", summary: "Vietnamese Chicken curry", description: " Add all the ingredients and cook them") 
    end
    
    test "recipe should be valid" do
        assert @recipe.valid?
    end
    
    test "chef_id must be present" do
        @recipe.chef_id = nil
        assert_not @recipe.valid?
    end
    
    test "name should be present" do
       @recipe.name = " "
       assert_not @recipe.valid?
    end
    
    test "name length should be <100" do
        @recipe.name = "a" * 101
        assert_not @recipe.valid?
    end
    
    test "name length should be >5" do
        @recipe.name = "aaaa"
        assert_not @recipe.valid?
    end
    
    test "summary should be present" do
       @recipe.summary = " "
       assert_not @recipe.valid?
    end
    
    test "summary length should be <150" do
        @recipe.summary = "a" * 151
        assert_not @recipe.valid?
    end
    
    test "summary length should be >10" do
        @recipe.summary = "a" * 9
        assert_not @recipe.valid?
    end
    
    test "description should be present" do
       @recipe.description = " "
       assert_not @recipe.valid?
    end
    
    test "description length should be <500" do
        @recipe.description = "a" * 501
        assert_not @recipe.valid?
    end
    
    test "description length should be >20" do
        @recipe.description = "a" * 19
        assert_not @recipe.valid?
    end
    
    
   
   
    
end