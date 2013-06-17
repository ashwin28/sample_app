class UsersController < ApplicationController
  before_filter :signed_in_user,    only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,      only: [:edit, :update]
  before_filter :admin_user,        only: [:destroy, :toggle_admin]
  before_filter :genuine_new_user,  only: [:new, :create]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end

  def toggle_admin
    user = User.find(params[:id])
    if current_user?(user)
      flash[:error] = "You cannot change your own administrative status."
    else
      user.toggle!(:admin)
      message = user.admin? ? "User now has administrative status." : "User has lost administrative status."
      flash[:success] = message
    end
    redirect_to users_url
  end

  def destroy
    user = User.find(params[:id])
    if current_user?(user)
      flash[:error] = "You cannot destroy yourself"
    else
      user.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_url
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    if params[:search]
      @users = User.where("name LIKE ?",
               "%#{params[:search]}%").paginate(page: params[:page]).order('name ASC')
      if @users.empty?
        flash[:error] = "No such users were found!"
        redirect_to users_url
      end
    else
      @users = User.paginate(page: params[:page])
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    
    def genuine_new_user
      if signed_in?
        redirect_to root_path, notice: "Already a valid user."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
