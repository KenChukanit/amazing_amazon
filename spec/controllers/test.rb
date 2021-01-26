require 'rails_helper'


def rspec(var, cla, class_controller,value)


# rails g rspec:controller job_posts --controller-specs --no-request-specs
RSpec.describe class_controller, type: :controller do
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
            it 'sets an instance variable with new job posts' do
                # Given
                # When
                get(:new)
                # Then
                expect(assigns(var)).to(be_a_new(cla))
                # assign(:job_past) is available from the 'rail-controller-testing'. this allows you to grab an instance varaibale, it takes symbol(:job_post)- the name of instance varaible
                # All models are available to controllers 
            end 
        end
    end# 👈🏻 describe 'new' ends  here 
    describe '#create' do# 👈🏻 describe 'create' starts here 
        def valid_request
            post(:create, params:{"#{var}": FactoryBot.attributes_for(var)})
        end
        context 'with user signed in' do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            context " with valid parameter " do # 👈🏻 Context Valid Parameters - Start
                it 'creates a job post in the database' do
                    # Given
                    count_before = cla.count
                    # When
                    valid_request
                    
                    # job_post:{
                    #     title: 'senior dev',
                    #     description: 'lots of pay',
                    #     location: 'remote',
                    #     min_salary:500_000,
                    #     max_salary:1_000_000
                    # }
                    #Then
                    count_after=cla.count
                    expect(count_after).to(eq(count_before + 1))
                end
                it 'redirects us to a show page of that post' do
                    # Given
                    # When
                    valid_request
                    
                    # Then 
                    value =cla.last
                    expect(response).to(redirect_to((value.id)))
                end
            end# 👈🏻 Context Valid Parameters - End
            context 'with invalid parameters' do
                def invalid_request
                    post(:create, params:{"#{var}": FactoryBot.attributes_for(var, title: nil)})
                end
                it 'doesnot save a record in the database'do
                    count_before = cla.count
                    invalid_request
                    count_after = cla.count
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

















end
end

rspec(:news_article,NewsArticle,NewsArticlesController,news_article)



# <div>
#  <small>
#     Liked by: <%= pluralize @review.likes.count, 'like' %>
#     </small>
#     <small>
#         <% if @like.present? %>
#         <%= link_to 'unlike', like_path(@like),method: :delete  %> 
#         <% else %>  
#         <%= link_to 'like', product_review_likes_path(@product, review, @like), method: :post  %> 
#         <% end %> 
#     </small>
# </div>