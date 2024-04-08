class ReviewsController < ApplicationController
  def index
    @reviews = Review.order(created_at: :desc)
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to reviews_path
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:name, :content, :summoner_name, :summoner_tag)
  end
end
