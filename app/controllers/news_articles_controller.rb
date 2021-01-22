class NewsArticlesController < ApplicationController
    before_action :authenticate_user!, except:[:index,:show]##lab1
    before_action :find_article, only:[:show,:update, :destroy, :edit]
    
    def new
        @news_article = NewsArticle.new
    end
    
    def create
        @news_article= NewsArticle.new news_article_params
        @news_article.user=current_user
        if @news_article.save
            redirect_to news_article_path(@news_article)
        else
            render :new
        end
    end

    def show
        @news_article =NewsArticle.find params[:id]
    end

    def index
        @news_articles =NewsArticle.all.order(created_at: :desc) 
    end

    def destroy
        if can?(:delete, @news_article)
        @news_article.destroy
        flash[:danger] = 'article deleted'
        redirect_to news_articles_path
        else  
            redirect_to root_path
            flash[:danger] = 'Not authorized'
        end
    end

    def edit
        if can?(:edit, @news_article)
            render :edit
        else
            redirect_to root_path
            flash[:danger] = 'Not authorized'
        end
    end

    def update
        if @news_article.update news_article_params
            redirect_to @news_article
        else  
            render :edit
        end
    end
    private
    def find_article
        @news_article =NewsArticle.find params[:id]
    end

    def news_article_params
        params.require(:news_article).permit(
            :title,
            :description,
            :published_at,
            :view_count,
            )
    end

    def authenticate_user!
        redirect_to new_session_path, notice: 'Please sign in' unless user_signed_in?
    end

    def authorize_user! #lab 2,3
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @news_article)
    end

end
