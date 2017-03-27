module ApplicationHelper
  def fix_url(url)
    url.start_with?('http://', 'https://') ? url : "http://#{url}"
  end

  def format_date_time(date_time)
    date_time.strftime('%m/%d/%Y %l:%M%P %Z')
  end
end
