class PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.all.order(created_at: :asc)
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.turbo_stream 
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end

  end

  def destroy
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
