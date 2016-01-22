require 'test_helper'

class UserTest < ActiveSupport::TestCase
   should validate_presence_of(:name)
   should validate_presence_of(:surname)
   
   test 'normalizes the name and surname before saving' do 
      user = User.new(name: 'Tom  ', surname: ' Smith', email: 'tom@example.com', password: default_password)
      
      user.save 
      
      assert_equal 'TOM', user.name 
      assert_equal 'SMITH', user.surname 
   end
   
   test '#full_name' do 
     user = users(:paul)
     assert_equal "#{user.name} #{user.surname}", user.full_name 
   end 
end
