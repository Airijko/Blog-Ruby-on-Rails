class ReviewsController < ApplicationController
    def index
        @post_forms = PostForm.order(created_at: :desc)
    end

    def show
        @post_form = PostForm.find(params[:id])
    end

    def new
        @post_form = PostForm.new
    end

    def create
        @post_form = PostForm.new(post_form_params)

        if @post_form.save
            redirect_to reviews_path
        else
            render :new
        end
    end

    private
        def post_form_params
            params.require(:post_form).permit(:description, :tags)
        end
end
