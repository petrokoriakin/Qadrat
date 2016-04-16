module UsersHelper
  def show_name(user)
    if user.username.empty?
      "User" + user.id.to_s
    else
      user.username
    end
  end
end
