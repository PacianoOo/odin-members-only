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
        format.html { redirect_to root_path }
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("posts", partial: "views/posts/post", locals: { post: @post }) }
      else
        format.html { render :new, status: :unprocessable_entity }
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
