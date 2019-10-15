class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
    if params[:song][:genre_id].empty?
      @song = Song.create(title: params[:song][:title], genre_id: params[:song][:genre_name], artist_id: Artist.find_or_create_by(name: params[:song][:artist_name]).id)
    else 
      @song = Song.create(title: params[:song][:title], genre_id: Genre.find_or_create_by(name: params[:song][:genre_id]).id, artist_id: Artist.find_or_create_by(name: params[:song][:artist_name]).id)
    end
    Note.create(content: params[:song][:notes_1], song_id: @song.id)
    Note.create(content: params[:song][:notes_2], song_id: @song.id)
    byebug 
    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist, :genre_id, :genre_name, :notes_1, :notes_2)
  end

end

