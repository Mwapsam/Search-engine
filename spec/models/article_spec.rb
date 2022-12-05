require 'rails_helper'

RSpec.describe Article, type: :model do
  before(:all) do
    @article = create(:article)
  end
    describe 'validations' do
      it 'is valid with valid attributes' do
        expect(@article).to be_valid
      end

      it "is not valid with a title more 150 words" do
        @article.title = Faker::Lorem.sentences(number: 200)
        expect(@article).to_not be_valid
      end
    
      it "is not valid with a body more than 2500 characters" do
        @article.body = Faker::Lorem.paragraph_by_chars(number: 3000)
        expect(@article).to_not be_valid
      end

      it "is not valid without a description" do
        @article.body = nil
        expect(@article).to_not be_valid
      end
    end
end
