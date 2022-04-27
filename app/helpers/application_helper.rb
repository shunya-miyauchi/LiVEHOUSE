module ApplicationHelper
  def this_week?(events, event)
    return unless events.first_page?
    events.this_week.present? && event == events[0]
  end

  def next_week?(events, event)
    events.next_week.present? && event == events.next_week[0]
  end
end
