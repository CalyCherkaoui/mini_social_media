require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "nameEx", email: "name@test.com")
  end

  test "@user should be valid" do
    assert @user.valid?
  end

  test "name shouldn't be null and it should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long more than 50 char" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long more that 255" do
    @user.email = "a" * 247 + "@test.com"
    assert_not @user.valid?
  end

  test "email should be a valid pattern it accept valid adresses" do
    valid_adresses = %w[user@test.com USER@bar.COM FOO_BAR@test.foo.bar.jp lady+oscar@mail.jp]
    valid_adresses.each do |adress|
      @user.email = adress
      assert @user.valid?, "#{adress.inspect} should be valid"
    end
  end

  test "email validation should reject invalid adresses" do
    invalid_adresses = %w[user@test,com user_mail.co lady@oscar@mail.jp sailor@@test+mail.moon]
    invalid_adresses.each do |adress|
      @user.email = adress
      assert_not @user.valid?, "#{adress.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
end
