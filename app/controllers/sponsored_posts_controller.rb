class SponsoredPostsController < ApplicationController
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def create
    @sponsored_post = SponsoredPost.new(sponsored_post_params)
    @topic = Topic.find(params[:topic_id])
    @sponsored_post.topic = @topic

    if @sponsored_post.save
      flash[:notice] = "Sponsored post was saved."
      redirect_to [@topic, @sponsored_post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.assign_attributes(sponsored_post_params)

    if @sponsored_post.save
      flash[:notice] = "Sponsored post was updated."
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash.now[:alert] = "There was an error saving the sponsored post. Please try again."
      render :edit
    end
  end

  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])

    if @sponsored_post.destroy
      flash[:notice] = "\"#{@sponsored_post.title}\" was deleted successfully."
      redirect_to @sponsored_post.topic
    else
      flash.now[:alert] = "There was an error deleting the sponsored post."
      render :show
    end
  end

  private
  def sponsored_post_params
    params.require(:sponsored_post).permit(:title, :body, :price)
  end
end
