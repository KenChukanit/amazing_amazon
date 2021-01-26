class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        @product = Product.find params[:product_id]
        review = Review.find params[:review_id]
        like = Like.new review: review, user: current_user
        if !can?(:like, review)
            flash[:alert] = "You can't like your own review"
        elsif like.save
            flash[:notice] = "Review Liked!"
        else
            flash[:warning] = like.errors.full_messages.join(', ')
        end
        redirect_to like.review.product
    end


    def destroy
        # When we destroy a like, we want to provide the like id directly to destroy
        like = Like.find params[:id]
        # This is defined in ability.rb
        if can? :destroy, like
            like.destroy
            flash[:success] = "Unliked Review"
            redirect_to like.review.product
        else 
            flash[:alert] = "Could not like review"
            redirect_to like.review.product
        end
    end





end
