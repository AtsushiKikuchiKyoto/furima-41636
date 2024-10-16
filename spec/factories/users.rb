FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.email}
    password {Faker::Internet.password(min_length: 6)+"12ab"}
    password_confirmation {password}
    last_name {"山田ああ"}
    first_name {"太郎イイ"}
    last_name_kana {"ヤマダ"}
    first_name_kana {"タロウ"}
    birthday {Faker::Date.between(from: '1930-01-01', to: '2019-12-31')}
  end
end