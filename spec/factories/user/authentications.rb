FactoryBot.define do
  factory :user_authentication, class: 'User::Authentication' do
    provider { "MyString" }
    uid { "MyString" }
    info { "" }
    credentials { "" }
    extra { "" }
    registration factory: :user_registration
  end
end
