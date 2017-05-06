module ApplicationHelper
  def japan_time(time)
    time.strftime('%Y年%m月%d日 %H:%M:%S')
  end
end
