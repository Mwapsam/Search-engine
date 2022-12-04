require 'rails_helper'

RSpec.describe Article, type: :model do
  before(:all) do
    @article = create(:article)
  end
    describe 'validations' do
      it 'is valid with valid attributes' do
        expect(@article).to be_valid
      end

      it "is not valid without a title" do
        @article.title = nil
        expect(@article).to_not be_valid
      end
    
      it "is not valid without a description" do
        @article.body = nil
        expect(@article).to_not be_valid
      end
    end
end
