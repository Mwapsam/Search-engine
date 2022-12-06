require 'rails_helper'

RSpec.describe UserSearch, type: :model do
  before(:all) do
    User.destroy_all
    UserSearch.destroy_all

    @user = create(:user)
    @user_search = create(:user_search, user_id: @user.id)
  end

  describe 'UserSearch validations' do
    it 'is valid with valid attributes' do
      expect(@user_search).to be_valid
    end

    it "is not valid without a title" do
      @user_search.title = nil
      expect(@user_search).to_not be_valid
    end

    it "is not valid without a title" do
      @user_search.title = Faker::Lorem.sentences(number: 200)
      expect(@user_search).to_not be_valid
    end
  end
end
