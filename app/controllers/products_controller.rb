class ProductsController < ApplicationController
    before_action :find_product, only:[:show, :edit, :update, :destroy]

    def new
        @product = Product.new
    end
    
    def create
        @product=Product.new product_params

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
end
