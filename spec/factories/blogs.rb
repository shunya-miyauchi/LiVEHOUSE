FactoryBot.define do
  factory :blog do
    title { 'タイトルあ' }
    content { '本文あ' }
    images { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/qujila-flower.png')) }
  end
  factory :blog_second, class: Blog do
    title { 'タイトルい' }
    content { '本文い' }
    images { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/ushibeaf.png')) }
  end
  factory :blog_third, class: Blog do
    title { 'タイトルう' }
    content { '本文う' }
    images { [ Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/ushibeaf.png'), 'spec/factories/images/qujila-flower.png') ] }
  end
end
