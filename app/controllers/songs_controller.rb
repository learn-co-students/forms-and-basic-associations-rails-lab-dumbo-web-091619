class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
    @genre = @song.genre
  end

  def new
    @song = Song.new
    @genres = Genre.all
    @song.notes.build(content: "first note")
    @song.notes.build(content: "second note")
  end

  def create
    @song = Song.create(song_params)
    redirect_to @song
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params(:title, :artist_name, :genre_id, notes_attributes: [:content]))

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

  def song_params(*args)
    params.require(:song).permit(:title, :artist_name, :genre_id, notes_attributes: [:content])
  end
end

