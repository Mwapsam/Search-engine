class UserSearchController < ApplicationController
  def index
    @results = User.all.includes(:user_searches)
  end

  def show
    @search_result = UserSearch.find(params[:id])
  end
end
