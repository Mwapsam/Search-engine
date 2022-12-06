require 'rails_helper'

RSpec.describe "Articles", type: :request do
  UserSearch.delete_all
  Article.delete_all
  User.delete_all
  let(:user) { FactoryBot.create(:user) }
  let(:article) {FactoryBot.create(:article)}
  let(:user_search) { FactoryBot.create(:user_search, user_id: user.id)}
  
  describe 'GET /articles' do
    before :example do
      login_as user, scope: :user

      get articles_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should render index view' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /articles/{id}' do
    before :example do
      login_as user, scope: :user

      get article_path(article.id)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should render article show view' do
      expect(response).to render_template(:show)
    end
  end
end
