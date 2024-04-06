class HomeController < ApplicationController
  def index
    @options = ['North America', 'Brazil', 'Europe Nordic & East', 'Europe West', 'Latin America North', 'Latin America South', 'Oceania', 'Russia', 'Turkey', 'Japan', 'South East Asia', 'Korea']
    @post_forms = PostForm.order(created_at: :desc).limit(3)
  end
end
