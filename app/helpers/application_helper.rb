module ApplicationHelper
  def quote str
    ('"' + str.gsub(/\"/, "\"") + '"').html_safe
  end
end
