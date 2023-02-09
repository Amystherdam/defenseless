FactoryBot.define do
  factory :user do
    email { 'user@user.com' }
    password { '12345678' }
    name { 'UserName' }
  end
end
