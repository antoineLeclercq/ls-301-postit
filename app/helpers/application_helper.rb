module ApplicationHelper
  def fix_url(url)
    url.start_with?('http://', 'https://') ? url : "http://#{url}"
  end

  def format_date_time(dt)
    if logged_in? && current_user.time_zone.present?
      dt = dt.in_time_zone(current_user.time_zone)
    end

    dt.strftime('%m/%d/%Y %l:%M%P %Z')
  end
end
