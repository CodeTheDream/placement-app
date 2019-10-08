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
    licensee = create(:licensee)
    service = create(:service)
    county = create(:county)

    new_placement_params = {
          name: 'Test',
          address: '1 New Street',
          city: 'Raleigh',
          state: 'NC', zip: '11111',
          county_id: county.id,
          phone: '111-111-1111',
          licensee_id: licensee.id,
          service_id: service.id,
          gender: 'male',
          beds: 3
        }

    post :create, params: {placement: new_placement_params }

    expect(response).to have_http_status(:redirect)

    placement = Placement.first

    expect(placement.name).to eq('Test')
  end

  it 'should update a placement' do
    licensee = create(:licensee)
    service = create(:service)
    county = create(:county)

    placement = create(:placement, licensee_id: licensee.id, service_id: service.id, county_id: county.id)
  
    placement_params = {
      name: 'Algernon',
      address: '2 old street',
      city: 'Durham',
      state: 'NC',
      county_id: county.id,
      phone: '111-222-6666',
      licensee_id: licensee.id,
      service_id: service.id,
      gender: 'male',
      beds: 3
    }

    put :update, params: {placement: placement_params, id: placement.id}

    placement.reload
    expect(placement.name).to eq("Algernon")
  end
end
