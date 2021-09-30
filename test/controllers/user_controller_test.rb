require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should not save user without FIRST_NAME" do
    user=User.new(LAST_NAME:'user', EMAIL_ID:'sampleuser@yopmail.com')
    assert_not user.save
  end

  test "should not save user without LAST_NAME" do
    user=User.new(FIRST_NAME:'Sample', EMAIL_ID:'sampleuser@yopmail.com')
    assert_not user.save
  end

  test "EMAIL_ID should be unique " do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  def setup
    @user = User.new(FIRST_NAME:'Sample',LAST_NAME:'user', EMAIL_ID:'sampleuser@yopmail.com')
  end
end
