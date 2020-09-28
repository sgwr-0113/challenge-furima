FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {'1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    first_name            { '菅原' }
    last_name             { '悠貴' }
    first_name_kana       { 'スガワラ' }
    last_name_kana        { 'ユウキ' }
    birth_date { Faker::Date.between_except(from: 20.year.ago, to: 1.year.from_now, excepted: Date.today) }
  end
end
