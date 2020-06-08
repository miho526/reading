class ToppagesController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end

end
