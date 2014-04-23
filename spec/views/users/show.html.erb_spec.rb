require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :email => "Email",
      :hashed_password => "Hashed Password",
      :salt => "Salt",
      :admin => false,
      :group => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/Hashed Password/)
    rendered.should match(/Salt/)
    rendered.should match(/false/)
    rendered.should match(/1/)
  end
end
