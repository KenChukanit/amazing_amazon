class VotesController < ApplicationController

    before_action :authenticate_user!
    before_action :find_vote, :authorize_user!, only: [:destroy, :update]

    def create 
        review = Review.find params[:review_id]
        vote = Vote.new user: current_user, review: review, result: params[:result]
        if !can?(:vote, review)
            flash[:alert] = "Can't vote on your own review"
        elsif vote.save 
            flash[:notice] = "Vote done"
        else
            flash[:alert] = vote.errors.full_messages
        end
        redirect_to review.product
    end

    def update 
        if !@vote.update(result: params[:result])
            flash[:alert] = @vote.errors.full_messages.join(', ')
        else
        redirect_to @vote.review.product 
        end
    end

    def destroy 
        @vote.destroy 
        redirect_to @vote.review.product 
    end


    private 

    def find_vote 
        @product = Product.find params[:product_id]
        @vote = Vote.find params[:id]
    end 

    def authorize_user!
        redirect_to @vote.review.product, alert: "Not your vote to change" unless can?(:crud, @vote)
    end

end
