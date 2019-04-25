FactoryBot.define do
 factory :user do
   email { 'wxyz@med.com' }
   password { "password" }
   password_confirmation  { "password" }
   first_name { "John" }
   last_name { "Johnson" }
   phone { "111-111-1111" }
   admin { true }
#    confirmed_at Date.today
 end
end
