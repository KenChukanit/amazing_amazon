class TagsController < ApplicationController

    def index
        @tags=Tag.all.order(created_at: :desc)
    end

    def show
        @tag = Tag.find params[:id]
        @products = @tag.products

    end

end
