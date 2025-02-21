class MoviesController < ApplicationController
  def create
    m = Movie.new
    m.title = params["query_title"]
    m.year = params["query_year"]
    m.duration = params["query_duration"]
    m.description = params["query_description"] 
    m.image = params["query_image"]
    m.director_id = params["query_director_id"]
    m.save

    redirect_to("/movies")
  end

  def modify
    m = Movie.where({ :id => params["path_id"] }).at(0)
    m.title = params["query_title"]
    m.year = params["query_year"]
    m.duration = params["query_duration"]
    m.description = params["query_description"] 
    m.image = params["query_image"]
    m.director_id = params["query_director_id"]
    m.save

    redirect_to("/movies/#{params["path_id"]}")
  end
  
  def delete
    m = Movie.where({ :id => params["path_id"] }).at(0)
    m.destroy
    redirect_to("/movies")
  end

  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
