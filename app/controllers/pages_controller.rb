class PagesController < ApplicationController

  def about
  end

  def alltags
    @alltags = ActsAsTaggableOn::Tag.all
  end

  protected
    def user_params
      params.require(:user).permit(:information)
    end
end
