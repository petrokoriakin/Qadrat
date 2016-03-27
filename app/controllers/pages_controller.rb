class PagesController < ApplicationController

  def about
  end

  def profile
    @currentUser = current_user
  end
end
