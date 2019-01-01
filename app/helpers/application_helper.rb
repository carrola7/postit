module ApplicationHelper
  def format_date(date)
    date.strftime("on %e/%m/%y at %H:%M")
  end

  def format_url(url)
    'http://' + url unless url.match(/http[s]?:\/\//)
  end

  def ajax_flash
    response = ""
    flash.each do |name, msg|
      if msg.is_a?(String)
        response = "<div class=\"alert alert-#{name == :notice ? 'success' : 'error'} ajax_flash\"><a class=\"close\" data-dismiss=\"alert\">&#215;</a> <div id=\"flash_#{name == :notice ? 'notice' : 'error'}\">#{msg}</div> </div>"
      end 
    end
    flash.clear
    response.html_safe
  end
end
