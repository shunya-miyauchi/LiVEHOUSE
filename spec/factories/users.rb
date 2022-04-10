FactoryBot.define do
  factory :user do
    name { 'たかはし' }
    display_name { 'takahashi' }
    email { 'aaa@gmail.com' }
    password { '123456' }
    password_confirmation { '123456' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/qujila-flower.png')) }
  end
  factory :user_second, class: User do
    name { 'やまもと' }
    display_name { 'yamamoto' }
    email { 'bbb@gmail.com' }
    password { '1234567' }
    password_confirmation { '1234567' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/ushibeaf.png')) }
  end
  factory :user_third, class: User do
    name { 'みやうち' }
    display_name { 'miyauchi' }
    email { 'ddd@gmail.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
