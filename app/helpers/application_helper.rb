module ApplicationHelper
# Return a title on a per-page basis.
  def page_title
    base_title = "Grapevine - Email and Text Online Review Monitoring"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
