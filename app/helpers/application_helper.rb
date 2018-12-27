module ApplicationHelper
  def format_date(date)
    date.strftime("on %e/%m/%y at %H:%M")
  end

  def format_url(url)
    'http://' + url unless url.match(/http[s]?:\/\//)
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= (session[:user_id] && User.find(session[:user_id]))
  end
end
