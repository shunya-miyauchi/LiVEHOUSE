FactoryBot.define do
  factory :user do
    name { 'たかはし' }
    display_name { 'takahashi' }
    email { 'aaa@gmail.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end
  factory :user_second, class: User do
    name { 'やまもと' }
    display_name { 'yamamoto' }
    email { 'bbb@gmail.com' }
    password { '1234567' }
    password_confirmation { '1234567' }
  end
end
