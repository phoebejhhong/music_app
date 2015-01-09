class AlbumsController < ApplicationController

  def new
    @album = Album.new
    @album.band_id = params[:band_id]
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      render :edit
    end
  end

  def destroy
    album = Album.find(params[:id])
    band = album.band
    album.destroy
    redirect_to band_url(band)
  end


  private
  def album_params
    params.require(:album).permit(:name, :band_id, :kind)
  end
end
