class DirectorsController < ApplicationController

  def search
    id = params[:movie_id] # retrieve movie ID from URI route
    movie = Movie.find(id)
    @director = movie.director
    if @director.nil? || @director == ""
      redirect_to "/movies"
      return
    end
    @movies = Movie.with_director(@director)
    render "similar_movies"
  end

end