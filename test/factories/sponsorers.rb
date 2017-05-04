FactoryGirl.define do
  factory :sponsorer do
    name {Faker::Name.name}
    email { Faker::Internet.email }
    password {Faker::Internet.password}
    sign_in_count {Faker::Number.digit}
    github_handle {Faker::Internet.user_name}
  end
end
