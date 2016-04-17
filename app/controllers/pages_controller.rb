class PagesController < ApplicationController

  def about
  end

  def alltags
    @tags = Tag.all.sort_by{ |tag| tag.posts.size }.reverse
  end
end
