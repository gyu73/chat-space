module ApplicationHelper
  def current_date_in_Japanese(time)
    time.strftime('%Y年%m月%d日 %H:%M:%S')
  end
end
