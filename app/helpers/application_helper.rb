module ApplicationHelper
  def full_title page_title = ""
    base_title = t :base_title
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def flash_color type
    case type
    when "notice"
      :info
    when "alert"
      :warning
    else
      type
    end
  end
end
