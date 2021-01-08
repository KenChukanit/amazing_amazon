class ContactUsController < ApplicationController
    def index

    end
    
    def thank_you
        @name = params[:name]
        @email = params[:email]
        @question = params[:question]
      end
end
