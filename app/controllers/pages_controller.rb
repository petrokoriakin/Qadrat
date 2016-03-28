class PagesController < ApplicationController

  def about
  end

  protected
    def user_params
      params.require(:user).permit(:information)
    end
end
