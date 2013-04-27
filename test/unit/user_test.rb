require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)
  # test "the truth" do
  #   assert true
  # end

  test "a user should enter first name" do
  		  		user = User.new
  		user.profile_name = users(:dee).profile_name

  		assert !user.save
  		assert !user.errors[:first_name].empty?
  end

  test "a user should enter last name" do
  		user = User.new
  		assert !user.save
  		assert !user.errors[:last_name].empty?
  end

    test "a user should enter profile name" do
  		user = User.new
  		assert !user.save
  		assert !user.errors[:profile_name].empty?
  end


    test "a user should have unique profile name" do
  		user = User.new
  		user.profile_name = users(:dee).profile_name
  		
  		assert !user.save
		#puts user.errors.inspect
  		assert !user.errors[:profile_name].empty?

  end

  test "a user should have a profile name without spaces" do
      user = User.new(first_name: 'Duaaaane', last_name: 'Weeettaker', email: 'dw@x.com')
      user.password = user.password_confirmation = 'sdarafeaf'

  		assert !user.save
  		assert !user.errors[:profile_name].empty?
  		assert user.errors[:profile_name].include?("Must be formatted properly")

  end

  test "a user can have a correctly formatted profile name" do
      user = User.new(first_name: 'Duaaaane', last_name: 'Weeettaker', email: 'dw@x.com')
      user.password = user.password_confirmation = 'sdarafeaf'

      user.profile_name = 'duuuuanne'

      assert user.valid?

  end

  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:dee).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:dee).friends << users(:mike)
    users(:dee).friends.reload
    assert users(:dee).friends.include?(users(:mike))
  end










end
