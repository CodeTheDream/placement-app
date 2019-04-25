require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
include Devise::Test::ControllerHelpers

def setup
   @request.env["devise.mapping"] = Devise.mappings[:user]
   @admin = FactoryBot.create(:user)
   sign_in @admin
 end


  before :each do
    setup
  end

  it 'should create user' do

    post :create, params: {user: {email: 'bob@example.com',
          password: '111111',
          password_confirmation: '111111', first_name: 'Bob', last_name: 'Smith',
          phone: '111-111-1111', admin: false} }

    user = User.last

    expect(user.last_name).to eq("Smith")
  end

end
