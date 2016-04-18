class ResultsController < ApplicationController
  def index
    @search_results = Post.search_everywhere(params[:query]).page(params[:page]).per(12)
  end
end
