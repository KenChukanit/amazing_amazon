# Write tests for the following:


# Users Controller

# new action
# a. renders the new template
# b. sets an instance variable of User type

# create action:
# a. with valid parameters: created a user in the DB, redirects to home page and signs the user in
# b. with invalid parameters: renders the new template and doesn't create a user in the database


require 'rails_helper'
RSpec.describe UsersController, type: :controller do
    describe '#new' do
            it 'renders the new template' do #1
            get :new
            expect(response).to render_template(:new)
            end

            it 'sets an instance variable with user type' do #2
            get :new
            expect(assigns(:user)).to be_a_new(User) 
            end
        
    end#End of #new
    describe '#create' do
            context 'valid parameter' do
                def valid_request
                    post(:create, params:{user: FactoryBot.attributes_for(:user)})
                end
                it 'create new userin database' do #3
                    count_before = User.count
                    valid_request
                    count_after = User.count
                    expect(count_after).to(eq(count_before + 1))
                end
                it 'redirects us to a root page' do #4
                    valid_request
                    expect(response).to(redirect_to(root_path))
                end
                it 'Logged in' do #5
                    valid_request
                    @user = FactoryBot.create(:user)
                    session[:user_id]=@user.id
                    expect(response).to(redirect_to(root_path))
                end
            end
            context 'Invalid' do 
                def invalid_request
                    post(:create, params:{user: FactoryBot.attributes_for(:user, first_name: nil)})
                end
                it 'does not record in DB' do #6
                    count_before = User.count
                    invalid_request
                    
                    count_after = User.count
                    expect(count_after).to(eq(count_before))
                end
                it 'renders new template' do #7
                    invalid_request
                    expect(response).to render_template(:new)
                end
            end
    end
  
end

