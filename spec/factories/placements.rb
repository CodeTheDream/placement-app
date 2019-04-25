FactoryBot.define do
 factory :placement do
   name { "Test" }
   address { "1 New Street" }
   city  { "Raleigh" }
   state { "NC" }
   zip { "11111" }
   county { "Wake" }
   phone { "111-111-1111" }
   licensee_id { 1 }
   gender {"male"}
   beds { 3 }
#    confirmed_at Date.today
  end

  factory :licensee do
    facility_name { "Test" }
    contact_name { "Test" }
    address { "Test" }
    city  { "Raleigh" }
    state { "NC" }
    zip { "11111" }
    phone { "111-111-1111" }
    fax { "111-111-1112" }
  end
  # :facility_name, :contact_name,
  #                                  :address, :city, :state, :zip, :phone,
  #                                  :fax
end
