class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end

    def search
        if params[:query].present?
            @search_results = Article.article_search(params[:query])
            @search_results.each do |article|
                save_results(article.title)
            end
        else
            @search_results = []
        end
        respond_to do |format|
            format.turbo_stream do
                render turbo_stream: turbo_stream.update("search_results",
                    partial: "articles/search_results", locals: { articles: @search_results })
            end
        end
    end

    def save_results(data)
        results = UserSearch.new(title: data, user_id: current_user.id)
        results.save!
    end
end
