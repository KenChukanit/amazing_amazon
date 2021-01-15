class ReviewsController < ApplicationController
    before_action :authenticate_user!#
    def create
        @product = Product.find params[:product_id]
        @review = Review.new review_params
        @review.user = current_user ##
        @review.product = @product
        if @review.save
            redirect_to product_path(@product), notice: "Review created"
        else  
            render '/products/show'
        end
    end

    def destroy
        @product = Product.find params[:product_id]
        @review = Review.find params[:id]
        @review.destroy
        redirect_to product_path(@product), notice: "Review deleted"
    end

    private
    def review_params 
        params.require(:review).permit(:body, :rating)
    end

end
