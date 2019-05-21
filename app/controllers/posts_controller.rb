class PostsController < ApplicationController
  before_action :album_id

  def index
    @posts = @album.posts.all
  end

  def new
    @post = @album.posts.new   
  end

  def create
    @post = @album.posts.new(post_params)
    if @post.save
      redirect_to album_post_path(@album,@post)
    else
      render 'new'
    end
  end

  def show
    @post = @album.posts.find(params[:id])
  end

  def destroy
    @post = @album.posts.find(params[:id])
    @post.destroy
    redirect_to album_posts_path(@album)
  end

  private

    def post_params
      params.require(:post).permit(:title, :image)
    end

    def album_id
      @album = Album.find(params[:album_id])
    end

end