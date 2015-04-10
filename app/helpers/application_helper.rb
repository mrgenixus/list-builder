module ApplicationHelper
  def quote str
    ('"' + str.gsub(/\"/, "\"") + '"').html_safe
  end

   def avatar_url(user, size = 64)
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
    end
end
