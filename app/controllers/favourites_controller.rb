class FavouritesController < ApplicationController

    def index
        @favourites = current_user.favoured_products.order(created_at: :desc)
        
    end

    def create
        product = Product.find params[:product_id]
        favourite = Favourite.new user: current_user, product: product
        if !can?(:favourite, product)
            flash[:alert] = "You can't favourite your own product"
        elsif favourite.save
            flash[:success] = "Product favourited!"
            redirect_to product
        else
            flash[:warning] = favourite.errors.full_messages.join(', ')
        end
    end

    def destroy
        favourite = Favourite.find params[:id]
        if can? :destroy, favourite
            favourite.destroy
            flash[:success] = "Unfavourited Review"
            redirect_to favourite.product
        else 
            flash[:alert] = "Could not favourite review"
            redirect_to favourite.product
        end
    end
end