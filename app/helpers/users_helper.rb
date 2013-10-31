module UsersHelper

  def avatar_url(user, size = 50)
    # if user.avatar_url.present?
    #   user.avatar_url
    # else
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
    # end
  end

end