require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe 'GET #new' do
        it 'renders the new template' do
            get :new
            # debugger
            expect(response).to render_template(:new)
        end
    end


    describe 'POST #create' do
            let(:user_params) do 
                { user: {
                    username: 'Kevin',
                    password: 'password',
                    email: 'kev@aa.io',
                    age: 29
                } }
            end
        context 'with valid params' do

            
            it 'logs the user in' do
                post :create, params: user_params
                user = User.find_by(username: 'Kevin')
                # debugger
                expect(session[:session_token]).to eq(user.session_token)
            end

            it 'redirects to the user\'s show page' do
                post :create, params: user_params
                user = User.find_by(username: 'Kevin')
                expect(response).to redirect_to(user_url(user))
            end

        end

        context 'with invalid params' do

            it 'validates the presence of password and renders the new template with errors' do
                post :create, params: { user: {
                    username: 'Kevin',
                    email: "kev@aa.io",
                    password: '',
                    age: 29
                } }
                expect(response).to render_template(:new)
                expect(flash[:errors]).to be_present
            end

        end

    end

end
