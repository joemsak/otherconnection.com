FactoryBot.define do
  factory :user_authentication, class: 'User::Authentication' do
    sequence(:provider) { |n| "provider-#{n}" }
    sequence(:uid) { |n| "uid-#{n}" }
    info { {} }
    credentials { {} }
    extra { {} }
    registration factory: :user_registration

    transient do
      email { "" }
    end

    after(:build) do |auth, evaluator|
      auth.info ||= {}
      auth.info["email"] ||= evaluator.email
    end
  end
end
