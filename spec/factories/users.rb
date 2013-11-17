FactoryGirl.define do
  sequence :email do |n|
      "person#{n}@example.com"
  end

  factory :user do
      email       
      password 'changeme'
      password_confirmation 'changeme'
  end
end

