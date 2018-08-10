class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :find_user, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page]).per_page Settings.paginate_per
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".please_check_mail"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page])
                       .per_page Settings.paginate_per
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t ".cannot_find_user"
    redirect_to root_url
  end

  def correct_user
    redirect_to root_url unless @user.current_user? current_user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
