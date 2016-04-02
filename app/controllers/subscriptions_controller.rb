class SubscriptionsController < ApplicationController

  def follow_tag

    if params[:tag]
      @tag = Tag.find_by_name(params[:tag])
      if current_user.follow(@tag.id)
        redirect_to root_path
      end
    end
  end

  def unfollow_tag

    if params[:tag]
      @tag = Tag.find_by_name(params[:tag])
      if current_user.unfollow(@tag.id)
        redirect_to root_path
      end
    end
  end
end
