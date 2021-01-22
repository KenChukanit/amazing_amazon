# Add the following tests for NewsArticleController new and create actions:
# new
# If a user is not signed in, redirect the user to the sign up page.
# If a user is signed in, all current tests should be able to pass.
# create
# If a user is not signed in, redirect the user to the sign up page.
# If a user is signed in, ...
# all current tests should be able to pass.
# associates the news article with the signed in user
require 'rails_helper'
RSpec.describe NewsArticlesController, type: :controller do
    describe '#new' do
        context 'User signed in' do ###########
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            it 'renders the new template' do #1
            get :new
            expect(response).to render_template(:new)
            end

            it 'sets an instance variable with a new article instance' do #2
            get :new
            expect(assigns(:news_article)).to be_a_new(NewsArticle) 
            end
        context 'User not signed in' do #########
            before do
                session[:user_id]= nil
            end
            it 'redirect to new session template' do #3
                get :new
                expect(response).to redirect_to(new_session_path)
            end
        end
        end
    end#End of #new
    describe '#create' do
        context 'with user signed in' do #########
            before do
                session[:user_id] = FactoryBot.create(:user)
            end
            context 'valid parameter' do
                def valid_request
                    post(:create, params:{news_article: FactoryBot.attributes_for(:news_article)})
                end
        
                it 'create new article in database' do #3
                    count_before = NewsArticle.count
                    valid_request
                    
                    count_after = NewsArticle.count
                    expect(count_after).to(eq(count_before + 1))
                end
                it 'redirects us to a show page of that article' do #4
                    valid_request
                    news_article = NewsArticle.last
                    expect(response).to(redirect_to(news_article_path(news_article.id)))
                end
            end
            context 'Invalid' do
                def invalid_request
                    post(:create, params:{news_article: FactoryBot.attributes_for(:news_article, title: nil)})
                end
                it 'does not record in DB' do
                    count_before = NewsArticle.count
                    invalid_request
                    
                    count_after = NewsArticle.count
                    expect(count_after).to(eq(count_before))
                end
                it 'renders new template' do
                    invalid_request
                    expect(response).to render_template(:new)
                end
            end
            end
        context 'Not Signed in' do
            def valid_request
                post(:create, params:{news_article: FactoryBot.attributes_for(:news_article)})
            end
            it 'should redirect to sign in page' do
                #given
                # User is not signed 
                #when
                valid_request
                #then
                expect(response).to redirect_to(new_session_path)
            end
        end
    end##End of #create
    describe '#show' do
        it 'renders show template' do
            news_article = FactoryBot.create(:news_article)
            get(:show, params:{ id: news_article.id})
            expect(response).to render_template(:show)
        end
        it 'set am instance variable @news_article for show' do
            news_article = FactoryBot.create(:news_article)
            get(:show, params:{ id: news_article.id})
            expect(assigns(:news_article)).to(eq(news_article))
        end
    end
    describe '#index' do
        it 'render index template'do
        get(:index)
        expect(response).to render_template(:index)
        end
        it 'assign variable @news_article_posts' do
            news_article1 = FactoryBot.create(:news_article)
            news_article2 = FactoryBot.create(:news_article)
            news_article3 = FactoryBot.create(:news_article)
            get(:index)
            expect(assigns(:news_articles)).to eq([news_article3, news_article2, news_article1])
        end
    end
    describe '#destroy' do
        before do
            @news_article = FactoryBot.create(:news_article)
            delete(:destroy, params:{id: @news_article.id})
        end
        it 'remove article from DB' do
            expect(NewsArticle.find_by(id: @news_article.id)).to(be(nil))
        end
        it 'redirect to index template' do
            expect(response).to redirect_to(news_articles_path)
        end
        it 'set a flash message' do
            expect(flash[:danger]).to be
        end
    end
    describe '#edit' do
        it 'render edit template' do
            news_article = FactoryBot.create(:news_article)
            get(:edit, params: {id: news_article.id})
            expect(response).to render_template(:edit)
        end
    end
    describe '#update' do
        before do
            @news_article = FactoryBot.create(:news_article)
        end
        context 'Valid parameter' do
            it 'update news_article record' do
                new_description = "new description"
                patch(:update, params:{id: @news_article.id, news_article:{description: new_description}})
                expect(@news_article.reload.description).to(eq(new_description))
            end
            it 'redirect to @news_article' do
                new_description = "new description"
                patch(:update, params:{id: @news_article.id, news_article:{description: new_description}})
                expect(response).to redirect_to(@news_article)
            end
        end
        context 'Invalid parameter' do
            it 'not update the record' do
                patch(:update, params:{id: @news_article.id, news_article:{description: nil}})
                expect(@news_article.reload.description).to(eq(@news_article.description))
            end
            it 'still render edit page' do
                patch(:update, params:{id: @news_article.id, news_article:{description: nil}})
                expect(@news_article.reload.description).to(eq(@news_article.description))
                expect(response).to render_template(:edit)
            end
        end
    end

end
