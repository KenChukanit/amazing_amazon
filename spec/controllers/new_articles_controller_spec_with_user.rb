require 'rails_helper'
RSpec.describe NewsArticleController, type: :controller do
    describe '#new' do # 👈🏻 describe 'new' starts here 
        context "with signed in user" do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end

            
            it 'render the new template' do
                # Given

                # When
                get(:new)

                # Then
                expect(response).to(render_template(:new)) #👈🏻 We wverify that the response will render out the tempalte called 'new' using the matcher 'render_template'
                # response is an object that re-presents the HTTP- Response
                # Rspec makes this opbejct available within the specs
            end
            it 'sets an instance variable with articles' do
                # Given
                # When
                get(:new)
                # Then
                expect(assigns(:news_article)).to(be_a_new(NewsArticle))
               
            end 
        end
    end# 👈🏻 describe 'new' ends  here 
    describe '#create' do# 👈🏻 describe 'create' starts here 
        def valid_request
            post(:create, params:{news_article: FactoryBot.attributes_for(:news_article)})
        end
        context 'with user signed in' do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            context " with valid parameter " do # 👈🏻 Context Valid Parameters - Start
                it 'creates an article post in the database' do
                    # Given
                    count_before = NewsArticle.count
                    # When
                    valid_request
                    #Then
                    count_after=NewsArticle.count
                    expect(count_after).to(eq(count_before + 1))
                end
                it 'redirects us to a show page of that post' do
                    # Given
                    # When
                    valid_request
                    
                    # Then 
                    news_article = NewsArticle.last
                    expect(response).to(redirect_to(news_article_url(news_article.id)))
                end
            end# 👈🏻 Context Valid Parameters - End
            context 'with invalid parameters' do
                def invalid_request
                    post(:create, params:{news_article: FactoryBot.attributes_for(:news_article, title: nil)})
                end
                it 'doesnot save a record in the database'do
                    count_before = NewsArticle.count
                    invalid_request
                    count_after = NewsArticle.count
                    expect(count_after).to(eq(count_before))
                end
                it 'renders the new template' do
                    # Given
                    # when
                    invalid_request
                    #then
                    expect(response).to render_template(:new)
                end
            end
        end# 👈🏻 context 'with user signed in' ends here
        context 'with user not signed in'do
            it 'should redirect to sign in page' do
                #given
                # User is not signed 
                #when
                valid_request
                #then
                expect(response).to redirect_to(new_session_path)
            end
        end
    end# 👈🏻 describe 'create' ends here 
    describe '#show' do# 👈🏻 describe 'show' start here 
        it 'render show template' do
            # Given
            news_article=FactoryBot.create(:news_article)
            # When
            get(:show, params:{id: news_article.id})
            # Then
            expect(response).to render_template(:show)
        end
        it 'set an instance variable @news_article for the shown object' do
            # Given
            news_article=FactoryBot.create(:news_article)
            # When
            get(:show, params:{id: news_article.id})
            # Then
            expect(assigns(:news_article)).to(eq(news_article))
            
        end
    end# 👈🏻 describe 'show' ends here 
    describe '#index' do # 👈🏻 describe 'index' starts here 
        it 'render the index template' do
            #given
            #when
            get(:index)
            #then
            expect(response).to render_template(:index)
        end
        it 'assign an instance variable @news_articles which contains all created articles' do
            # Given
            news_article_1=FactoryBot.create(:news_article)
            news_article_2=FactoryBot.create(:news_article)
            news_article_3=FactoryBot.create(:news_article)
            # When
            get(:index)
            # Then
            expect(assigns(:news_article)).to eq([news_article_3, news_article_2,news_article_1])
        end
    end# 👈🏻 describe 'index' ends here 
    describe "# edit" do# 👈🏻 describe 'edit' starts here 
        context "with signed in user" do
            context " as owner" do
                before do
                    # session[:user_id]=FactoryBot.create(:user)
                    current_user=FactoryBot.create(:user)
                    session[:user_id]= current_user.id
                    @news_article=FactoryBot.create(:news_article, user: current_user)
                end
                it "render the edit template" do
                    # Given
                    
                    #When
                    get(:edit, params:{id: @news_article.id})
                    # then
                    expect(response).to render_template :edit
                end
            end
            context 'as non owner' do
                before do
                    current_user=FactoryBot.create(:user)
                    session[:user_id]=current_user.id
                    @news_article=FactoryBot.create(:news_article)
                end
                it 'should redirect to the show page' do
                    get(:edit, params:{id:@news_article.id})
                    expect(response).to redirect_to news_article_path(@news_article)
                end
            end
        end
    end# 👈🏻 describe 'edit' ends here 
    describe '#update' do# 👈🏻 describe 'update' starts here 
        before do
            #given
            @news_article= FactoryBot.create(:news_article)
        end
        context "with signed in user"do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            context "with valid parameters" do
                it "update the article record with new attributes" do

                    #when
                    new_title = "#{@news_article.title} plus some changes!!!"
                    patch(:update, params:{id: @news_article.id, news_article:{title: new_title}})
                    #then
                    expect(@news_article.reload.title).to(eq(new_title))
                end
                it 'redirect to the show page' do
                    new_title = "#{@news_article.title} plus some changes!!!"
                    patch(:update, params:{id: @news_article.id, news_article:{title: new_title}})
                    expect(response).to redirect_to(@news_article)

                end
            end
            context 'with invalid parameters' do 
                it 'should not update the article record' do
                    patch(:update, params:{id: @news_article.id, news_article: {title: nil}})
                    news_article_after_update = NewsArticle.find(@news_article.id)
                    expect(news_article_after_update.title).to(eq(@news_article.title))
                end
            end
        end 
    end# 👈🏻 describe 'update' ends here 
    describe '#destroy' do
        context "with signed in user" do
            context 'as owner' do
                before do
                    #given
                    # As given we have already created rights / ability in ability.rb
                    # Here we need a user who is also an owner of the article 
                    # so he can delete that article
                    current_user=FactoryBot.create(:user)
                    session[:user_id]=current_user.id
                    @news_article=FactoryBot.create(:news_article, user: current_user)
                    #when
                    delete(:destroy, params:{id: @news_article.id})
                end
                it 'remove article post from the db' do
                    #then 
                    expect(NewsArticle.find_by(id: @news_article.id)).to(be(nil))
                end
                it 'redirect to the article index' do
                    expect(response).to redirect_to(news_articles_path)
                end
                it 'set a flash message' do
                    expect(flash[:danger]).to be
                end 
            end
            context "as non owner" do
                before do
                    current_user = FactoryBot.create(:user)
                    session[:user_id]=current_user.id
                    @news_article=FactoryBot.create(:news_article)
                end
                it 'does not remove the article' do
                    delete(:destroy,params:{id: @news_article.id})
                    expect(NewsArticle.find(@news_article.id)).to eq(@news_article)
                end
            end
        end
    end
end