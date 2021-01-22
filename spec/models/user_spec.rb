
# first_name must be present
# last_name must be present
# email must be unique
# full_name method must return first_name and last_name concatenated & titleized
# Users Controller

# new action
# a. renders the new template
# b. sets an instance variable of User type

# create action:
# a. with valid parameters: created a user in the DB, redirects to home page and signs the user in
# b. with invalid parameters: renders the new template and doesn't create a user in the database



require 'rails_helper'


RSpec.describe NewsArticle, type: :model do
  def user
      FactoryBot.create(:user)
  end

  describe 'validations' do
    it 'first name must be present' do
      u = user
      u.first_name = nil
      u.valid?
      expect(u.errors).to have_key(:first_name)
    end

    it 'last name must be present' do 
      u = user
      u.last_name = nil
      u.valid?
      expect(u.errors).to have_key(:last_name)
    end
    
    it 'email must be  unique' do 
      u = user
      u2 = FactoryBot.build(:user, email: u.email)
      u2.valid?
      expect(u2.errors).to have_key(:email)
    end

    it 'return fullname' do
      u = user

    end

    describe '#fullname' do
      it 'set fullname with titlized' do
        u = user
        u.full_name
        expect(u.full_name).to eq("#{u.first_name.capitalize!} #{u.last_name.capitalize!}")
      end
    end
  end
    
  
    # it 'full_name method must return first_name and last_name concatenated & titleized' do
    #   u = user
    #   u.save
    #   n.published_at = n.created_at
    #   n.valid?
    #   expect(n.errors).to have_key(:published_at)
    # end
  end