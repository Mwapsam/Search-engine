require 'rails_helper'

RSpec.describe 'Category', type: :feature do
  before(:all) do
    UserSearch.destroy_all
    User.destroy_all
    Article.destroy_all
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article)
  end

  before(:each) do
    visit(new_user_session_path)
    within 'form' do
      fill_in('user_email', with: @user.email)
      fill_in('user_password', with: @user.password)
    end
    click_button('Login')
    visit(articles_path)
  end

  describe 'Test category index page' do
    scenario 'I can see the titles of all articles' do
      expect(page).to have_content(@article.title)
    end

    scenario 'confirm that we are on the articles index page' do
      expect(page).to have_current_path(articles_path)
    end

    scenario 'confirm that all articles are properly displayed' do
      @articles = Article.all
      @articles.each do |article|
        expect(page).to have_content(article.title)
      end
    end

    scenario 'narrow results for articles using the search box' do
        @article1 = Article.create(title: "Games of Thrones", body: Faker::Lorem.paragraph)

        visit articles_path

        fill_in :query, with: "game"

        expect(page).to have_text(@article1.title)
    end
  end
end