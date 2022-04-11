FactoryBot.define do
  factory :comment do
    user_id { user_id }
    event_id { event_id }
    content { "コメント１" }
  end
  factory :comment_second, class: Comment do
    user_id { user_id }
    event_id { event_id }
    content { "コメント２" }
  end
end
