require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
include Devise::Test::ControllerHelpers

def setup
   @request.env["devise.mapping"] = Devise.mappings[:user]
   #user = FactoryBot.create(:user)
 end


  before :each do
    setup
  end

  it 'should create user' do
    user = build(:user)

    post :create

    expect(user.first_name).to eq("Bob")
  end

end
