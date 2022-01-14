class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create]
  def index
    @posts = Post.all
    @post = Post.new
    @post_f = Post.all
    max = 0
    @ans = []
    @post_f.each do |v|
      if max < v.liked_users.count then
        @ans << v
        max = v.liked_users.count
      end
    end
    @max_count = max
    @rank_f = @ans.pop 
  end

  def show
    @post = Post.find(params[:id])
    @like = Like.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  # def rank
  #   @post_f = Post.all
  #   max = 0
  #   @max_count = 0
  #   ans = nil
  #   @post_f.each do |v|
  #     if max < v.likes.count then
  #       ans = v 
  #       @max_count = v.likes.count
  #     end
  #   end
  #   @rank_f = ans 
  # end

  private
  def post_params
    params.require(:post).permit(:content)
  end

end