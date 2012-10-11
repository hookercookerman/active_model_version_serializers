require 'factory_girl'

FactoryGirl.define do

  factory :user do
    trait :base do
      sequence(:id)
      name {'Richardo Alfrono'}
    end

    trait :version_1 do
      remote_image { "http://placekitten.com/400/400" }
      likes_beans { true}
    end

    trait :version_2 do
      likes_eggs {true}
    end

    trait :version_3 do
      date_of_birth { Time.now }
    end

    factory :v1_user,    traits: [:base, :version_1]
    factory :v2_user,    traits: [:base]
    factory :v3_user,    traits: [:base, :version_1, :version_3]
    factory :v4_user,    traits: [:base, :version_1, :version_2]
  end

  factory :turn do

    trait :turn_version_1 do
      sequence(:id)
      name {"Doing the eggs"}
      score {7}
    end

    trait :turn_version_2 do
      image {"http://placekitten.com/400/400"} 
    end
    factory :v1_turn,    traits: [:turn_version_1]
    factory :v2_turn,    traits: [:turn_version_1, :turn_version_2]
    factory :v3_turn,    traits: [:turn_version_1, :turn_version_2]
    factory :v4_turn,    traits: [:turn_version_1, :turn_version_2]
  end

  factory :car do
    trait :car_ish do
      audio_system { [:none, :radio, :cd_player, :turntables].sample }
      wheels { [3, 4, 6, 8].sample }
    end

    factory :v1_car, traits: [:car_ish] do
      colour { [:red, :green, :blue, :black, :white].sample }
    end

    factory :v2_car, traits: [:car_ish]
  end
end
