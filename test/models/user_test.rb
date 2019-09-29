require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(username:"trang", email:"tangsjk@mail.com", password:"soojba23")

  end
  test "user should be valid" do
    assert @user.valid?
  end

  test "user name should be present" do
    @user.username = " " * 10
    assert_not @user.valid?
  end

  test "user name should not be too long" do
    @user.username = "a" *55
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " " * 100
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a"*255 + "@example.com"
    assert_not @user.valid?
  end

  test "email format should accept valid email address" do
    valid_addresses = %w[example@xampe.com FAKSDFee@bar.foo amerai.brib@com.ca 
                          bar334jk@com.vn A_US@mail.com]
    valid_addresses.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} address should be valid"
    end
  end
  
  test "email format should not accept invalid email address" do
    invalid_addresses = %w[sfjlkf.com AFf@sdjlkf..com foo@bar_bar.com bar@bar+bar.com 
                           bar@baar.com.]
    invalid_addresses.each do |email|
    @user.email = email
    assert_not @user.valid?, "#{email.inspect} should not be valid"
    end
  end

  test "email should be saved as lower case" do
    mix_case = "DJSKK@baR.com"
    @user.email = mix_case
    @user.save 
    assert_equal mix_case.downcase, @user.reload.email
  end

  test "email address should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    assert dup_user.valid?
  end

  test "password should be present" do
    @user.password = " " *10
    assert_not @user.valid?
  end

  test "password should be at least 6 character" do
    @user.password = "a" *5
    assert_not @user.valid?
  end
end
