module ApplicationHelper
  def format_date(date)
    date.strftime("on %e/%m/%y at %H:%M")
  end

  def format_url(url)
    'http://' + url unless url.match(/http[s]?:\/\//)
  end
end
