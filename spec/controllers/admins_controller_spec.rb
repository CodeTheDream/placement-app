require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  include Devise::Test::ControllerHelpers

  def setup
   @request.env["devise.mapping"] = Devise.mappings[:user]
   @user = FactoryBot.create(:user)
   sign_in @user
  end

   before :each do
     setup
   end


  it 'should update user' do
    user_params = {
      email: 'timmy@example.com',
      password: '123456',
      password_confirmation: '123456',
      first_name: 'Timmy',
      last_name: 'Smith',
      phone: '111-222-6666',
      admin: false
    }

    put :update, params: {user: user_params, id: @user.id}

    @user.reload

    expect(@user.first_name).to eq("Timmy")
  end

  it 'should destroy user' do
    expect {
      delete :destroy, params: { id: @user.id }
    }.to change(User, :count).by(-1)
  end

  # let(:user) {
  #   User.create(
  #     email: 'tim@example.com',
  #     password: '111111',
  #     password_confirmation: '111111',
  #     first_name: 'Tim',
  #     last_name: 'Smith',
  #     phone: '111-222-6666',
  #     admin: true
  #   )
  #   }

end
