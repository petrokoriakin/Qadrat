module UsersHelper
  def show_name(user)
    if user.username.empty?
      "User" + user.id.to_s
    else
      user.username
    end
  end

  def subsribed_tags(user)
    user.subscribed_tags.map(&:name).map { |t| link_to t, tag_path(t) }.join(' ')
  end
end
