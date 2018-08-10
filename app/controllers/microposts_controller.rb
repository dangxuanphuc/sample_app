class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(destroy)

  def create
    @micropost = current_user.microposts.build(micropost_params)

    if @micropost.save
      flash[:success] = t ".micropost_created"
      redirect_to root_url
    else
      @feed_items = current_user.microposts.paginate page: params[:page]
      render "static_pages/home"
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = t ".micropost_deleted"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.nil?
  end
end
