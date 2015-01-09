class TracksController < ApplicationController

  def new
    @track = Track.new
    @track.album_id = params[:album_id]
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def destroy
    track = Track.find(params[:id])
    album = track.album
    track.destroy
    redirect_to album_url(album)
  end


  private
  def track_params
    params.require(:track).permit(:name, :album_id, :kind, :lyrics)
  end

end
