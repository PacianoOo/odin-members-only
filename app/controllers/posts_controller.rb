class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update]
  def index
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
    end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path }
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("posts", partial: "views/posts/post", locals: { post: @post }) }
      else
        format.html do 
          flash[:post_errors] = @post.errors.full_messages
          redirect_to root_path
        end
      end
    end
  end
    

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    respond_to do |format|
      if @post.destroy
        format.html { redirect_to root_path }
        format.turbo_stream { render turbo_stream: turbo_stream.remove("posts", partial: "views/posts/post", locals: { post: @post }) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to root_path }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("posts", partial: "views/posts/post", locals: { post: @post }) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  private

  def post_params
    params.require(:post).permit(:body)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
