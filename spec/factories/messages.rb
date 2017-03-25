FactoryGirl.define do

  factory :message do
    content "aaa"
    image { Faker::Avatar.image }
    user_id {Faker::Number.number(2)}
    chat_group_id {Faker::Number.number(2)}
  end

end
