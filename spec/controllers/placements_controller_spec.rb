require 'rails_helper'

RSpec.describe PlacementsController, type: :controller do
include Devise::Test::ControllerHelpers

  def setup
     @request.env["devise.mapping"] = Devise.mappings[:user]
     @user = FactoryBot.create(:user)
     sign_in @user
  end

  before :each do
    setup
  end

  it 'should create a placement' do
    create(:licensee)
    
    post :create, params: {placement: {name: 'Test',
          address: '1 New Street',
          city: 'Raleigh', state: 'NC', zip: '11111', county: 'Wake',
          phone: '111-111-1111', licensee_id: 1, gender: 'male', beds: 3} }

    expect(response).to have_http_status(:redirect)

    placement = Placement.first
    expect(placement.name).to eq('Test')
  end

  it 'should update a placement' do
    create(:licensee)
    placement = create(:placement)

    placement_params = {
      name: 'Algernon',
      address: '2 old street',
      city: 'Durham',
      state: 'NC',
      county: 'Durham',
      phone: '111-222-6666',
      licensee_id: 1,
      gender: 'male',
      beds: 3
    }

    put :update, params: {placement: placement_params, id: placement.id}

    placement.reload
    expect(placement.name).to eq("Algernon")
  end
end
