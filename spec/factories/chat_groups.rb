FactoryGirl.define do

  factory :chat_group do
    id {Faker::Number.number(1)}
    name { Faker::Zelda.character }
    created_at {Faker::Time.between(DateTime.now - 1, DateTime.now)}
    updated_at {Faker::Time.between(DateTime.now - 1, DateTime.now)}
  end

end
