require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :email => "MyString",
      :hashed_password => "MyString",
      :salt => "MyString",
      :admin => false,
      :group => 1
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", users_path, "post" do
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_hashed_password[name=?]", "user[hashed_password]"
      assert_select "input#user_salt[name=?]", "user[salt]"
      assert_select "input#user_admin[name=?]", "user[admin]"
      assert_select "input#user_group[name=?]", "user[group]"
    end
  end
end
