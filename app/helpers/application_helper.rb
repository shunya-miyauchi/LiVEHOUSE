module ApplicationHelper
  def this_week?(events, event)
    events.this_week.present? && events.first_page? && event == events[0]
  end

  def next_week?(events, event)
    events.next_week.present? && event == events.next_week[0]
  end
end
