class AlbumsController < ApplicationController
  before_action :album_id, only:[:show, :edit, :update, :destroy]

  def index
    @albums = Album.all
  end

  def new
    @album = Album.new
  end

  def create
    debugger
    @album = Album.new(album_params)
    @album.tag_ids = get_tag_ids(params[:tags].split(','))
    @album.user=current_user
    if @album.save
      redirect_to album_path(@album)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update    
    @album.tag_ids = get_tag_ids(params[:tags].split(','))
    if @album.update(album_params)
      redirect_to album_path(@album)
    else
      render 'edit'
    end
  end

  def destroy
    @album.destroy
    redirect_to user_path(@album.user.id)
  end

  private

    def album_params
      params.require(:album).permit(:title, :text, tags_attributes: [:id, :title])  
    end

    def album_id
      @album = Album.find(params[:id])
    end
    
    def get_tag_ids tags
      tags_list = []
      tags.each do |tag|
        if a=Tag.find_by_title(tag)
          tags_list << a
        else
          tags_list << Tag.create(title: tag)
        end
      end
      tags_list.pluck(:id)
    end
      
end
