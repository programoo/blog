FactoryBot.define do
  factory :chapter do
    title { "MyString" }
    description { "MyString" }
    content { "MyText" }
    position { 1 }
    movie { nil }
  end
end
