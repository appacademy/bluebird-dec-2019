require 'rails_helper'

RSpec.describe User, type: :model do


    # let(:invalid_user) { User.new(username: '', password: 'password') }
    # it 'validates presence of a username' do
    #     expect(:invalid_user).to_not be_valid
    # end

    it { should validate_presence_of(:username) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should have_many(:chirps) }

    subject(:kevin) { User.create(username: 'kevbot', email: 'kevbot@aa.io', age: 29,
    political_affiliation: 'hack reactor', password: 'password') }
    it { should validate_uniqueness_of(:username) }



    describe 'session_token' do
        it 'assigns a session_token if none given' do
            expect(FactoryBot.build(:user).session_token).not_to be_nil
        end
    end



    describe 'password encryption' do

        it 'does not save passwords to the database' do
            FactoryBot.create(:user, username: 'Harry Potter')
            user = User.find_by(username: 'Harry Potter')
            expect(user.password).not_to be('password')
        end

        it 'encrypts password using BCrypt' do
            expect(BCrypt::Password).to receive(:create).with('banana')
            FactoryBot.build(:user, password: 'banana')
        end

    end

end 