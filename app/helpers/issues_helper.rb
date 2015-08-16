module IssuesHelper
  def status_label(status)
    "<span class='label label-#{status_color_class(status)}'>#{status.titleize}</span>".html_safe
  end

  def status_color_class(status)
    case status.downcase
    when 'urgent'
      'danger'
    when 'closed'
      'default'
    else
      'info'
    end
  end
end
