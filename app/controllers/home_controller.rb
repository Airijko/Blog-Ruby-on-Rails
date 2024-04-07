class HomeController < ApplicationController
  include SearchHelper

  def index
    @post_forms = PostForm.order(created_at: :desc).limit(3)
    @player = session[:player]
    @regions = get_regions
  end
end
