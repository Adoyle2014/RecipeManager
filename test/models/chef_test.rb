require "test_helper"

class ChefTest < ActiveSupport::TestCase
   
   def setup
       @chef = Chef.new(chefname: "john", email: "john@example.com")
   end 
   
   test "chef must be valid" do
       assert @chef.valid?
   end
   
   test "chefname must be present" do
       @chef.chefname = " "
       assert_not @chef.valid?
   end
   
   test "chefname must be >40" do
       @chef.chefname = "a" * 41
       assert_not @chef.valid?
   end
   
   test "chefname must be <3" do
       @chef.chefname = "aa"
       assert_not @chef.valid?
   end
   
   test "email must be present" do
       @chef.email = " "
      assert_not @chef.valid? 
   end
   
   test "email must be <100" do
       @chef.email = "a" * 101 + "@example.com"
       assert_not @chef.valid?
   end
   
   test "email must be unique" do
      dup_chef = @chef.dup
      dup_chef.email = @chef.email.upcase
      @chef.save
      assert_not dup_chef.valid?
   end
   
   test "email validation must accept valid addresses" do
       valid_addresses = %w[user@eee.com R_TDD=DS@eee.hello.org user@example.com first.last@eee.au laura+joe@monk.cm]
       valid_addresses.each do |va|
           @chef.email = va
           assert @chef.valid?, "#{va.inspect} should be valid"
       end
   end
   
   test "email validation must reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am.com foo@eee+bar.com]
    invalid_addresses.each do |ia|
        @chef.email = ia
        assert_not @chef.valid?, "#{ia.inspect} should be invalid"
    end
   end
end