class ProductsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]#
    before_action :find_product, only:[:show, :edit, :update, :destroy]
    before_action :authorize_user!, only:[:edit,:update,:destroy]

    def new
        @product = Product.new
    end
    
    def create
        @product=Product.new product_params
        @product.user = current_user##

        if @product.save
            flash[:notice] = "Product created sucessfully."
            redirect_to product_path(@product.id)
        else
            render :new
        end
    end

    def index
        @products=Product.all.order(created_at: :desc)
    end

    def show
        @review = Review.new
        @reviews=@product.reviews.order(created_at: :desc)
        @like = @review.likes.find_by(user: current_user)
        @favourite = @product.favourites.find_by_user_id current_user if user_signed_in?
    end

    def edit
        
    end

    def update
        if @product.update product_params
            redirect_to product_path(@product.id),
            notice: "Product edited successfully."
        else
            render :edit
        end
    end

    def destroy
        @product.destroy
        redirect_to '/products'
    end

    private
    def find_product
        @product=Product.find params[:id] 
    end

    def product_params
        params.require(:product).permit(:title, :description, :price, :sale_price)
    # permit specifies all the input names that are allowes as symbol
    end

    def authorize_user!
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @product)
    end
end
