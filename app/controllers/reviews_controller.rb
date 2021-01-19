class ReviewsController < ApplicationController
    before_action :authenticate_user!#
    before_action :authorize_user!, only:[:edit,:update,:destroy, :delete]
    
    def new
        @review = Review.new
    end

    def create
        @product = Product.find params[:product_id]
        @review = Review.new review_params
        @review.user = current_user ##
        @review.product = @product
        @review_hide = params
        puts "-----------------inside review controller #{review_params}"
        if @review.save
            redirect_to product_path(@product), notice: "Review created"
        else  
            @reviews=@product.reviews.order(created_at: :desc)
            render '/products/show'
        end
    end

    def show
        puts "********************inside show"
    end

    def destroy
        @product = Product.find params[:product_id]
        @review = Review.find params[:id]
        #if can?(:crud, @review)
        @review.destroy
        redirect_to product_path(@product), notice: "Review deleted"
       # else  
         #   redirect_to root_path, alert: "Only review owner can delete the review"
       # end
    end
    def update
        @product = Product.find params[:product_id]
        @review = Review.find params[:id]
        if(@review.hide)
            @review.hide = false
        else
            @review.hide = true
        end
        print "****************inside update #{@review}"
        @review.save
        redirect_to product_path(@product)
    end

    private
    def review_params 
        params.require(:review).permit(:body, :rating)
    end

    def authorize_user!
        @review = Review.find params[:id]
        redirect_to root_path, alert: "Only review owner can delete the review" unless can?(:crud, @review)
    end

end
