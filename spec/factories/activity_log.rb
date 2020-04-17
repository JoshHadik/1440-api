FactoryBot.define do
  factory :activity_log do
    transient do
      date { Date.today }
    end

    user do
      FactoryBot.build(:user)
    end

    started_at do
      Time.zone.parse(Faker::Time.between(from: date.to_datetime, to: date.to_datetime.change(hour: 12)).to_s)
    end

    ended_at do
      Time.zone.parse(Faker::Time.between(from: started_at, to: date.to_datetime.change(hour: 23, min: 59)).to_s)
    end

    label do
      ["Run", "Swim", "Work", "Cook", "Sleep", "Read"].sample
    end

    trait :no_user do
      user { nil }
    end

    trait :invalid do
      started_at { nil }
      ended_at { nil }
      label { nil }
    end

    trait :started_at_greater_than_ended_at do
      ended_at do
        Time.zone.parse(Faker::Time.between(from: date.to_datetime, to: date.to_datetime.change(hour: 12)).to_s)
      end

      started_at do
        Time.zone.parse(Faker::Time.between(from: ended_at, to: date.to_datetime.change(hour: 23, min: 59)).to_s)
      end
    end
  end
end
