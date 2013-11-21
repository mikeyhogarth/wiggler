FactoryGirl.define do
  sequence :email do |n|
      "person#{n}@example.com"
  end

  factory :user do
      email       
      first_name 'test'
      last_name 'user'
      password 'changeme'
      password_confirmation 'changeme'
  end
end

