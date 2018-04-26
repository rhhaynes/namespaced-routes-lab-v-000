class ArtistsController < ApplicationController
  before_action :set_pref, only: [:index, :new]
  
  def index
    @pref.nil? ? @artists = Artist.all : @artists = Artist.order("name #{@pref.artist_sort_order}")
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    if Preference.last.allow_create_artists then @artist = Artist.new
    else redirect_to artists_path
    end
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    @artist.update(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private
  
  def set_pref
    @pref = Preference.last
  end

  def artist_params
    params.require(:artist).permit(:name)
  end
end
