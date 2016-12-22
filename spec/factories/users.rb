FactoryGirl.define do
  factory :user do

    sequence(:name) { |i| "user #{i}" }
    description { "description for #{name}"}

    authenticator 'local'
    email "triglav-test@example.com"
    groups { [] }

    to_create do |instance|
      instance.save validate: false
    end

    trait :triglav_admin do | user |
      groups { ["triglav_admin"] }
    end

    trait :project_admin do | user |
      groups { [ 'project_admin' ] }
    end

    trait :editor do | user |
      groups { [ 'editor' ] }
    end

    trait :read_only do | user |
      groups { [ 'read_only' ] }
    end
    
  end

end
