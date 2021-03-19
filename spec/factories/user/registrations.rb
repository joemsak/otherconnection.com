FactoryBot.define do
  factory :user_registration, class: 'User::Registration' do
    name { "Jack" }
    sequence(:email) { |n| "jack-#{n}@thehill.com" }
  end
end
