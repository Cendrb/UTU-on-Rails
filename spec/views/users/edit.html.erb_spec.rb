require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :email => "MyString",
      :hashed_password => "MyString",
      :salt => "MyString",
      :admin => false,
      :group => 1
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_hashed_password[name=?]", "user[hashed_password]"
      assert_select "input#user_salt[name=?]", "user[salt]"
      assert_select "input#user_admin[name=?]", "user[admin]"
      assert_select "input#user_group[name=?]", "user[group]"
    end
  end
end
