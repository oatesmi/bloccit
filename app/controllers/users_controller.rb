class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Welcome to Bloccit #{@user.name}!"
      create_session(@user)
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end

  def confirm
    ActionController::Parameters.permit_all_parameters = true

    @user = User.new(user_params)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user)
    @favorite_posts = get_favorite_posts(@user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def get_favorite_posts(user)
    posts = Post.all
    favorite_posts = posts.select{ |post| post.favorites.find_by_user_id(user.id) }
  end
end
