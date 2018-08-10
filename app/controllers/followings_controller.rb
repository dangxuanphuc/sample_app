class FollowingsController < ApplicationController
    attr_reader :user
  
    before_action :logged_in_user, :find_user, only: :index
  
    def index
      @title = t "following"
      @users = @user.following.paginate page: params[:page]
      render "users/show_follow"
    end
  
    private
    def find_user
      @user = User.find_by id: params[:id]
  
      return if user
      flash[:danger] = :cannot_find_user
      redirect_to root_url
    end
  end
