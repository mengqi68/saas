# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    session[:sort] = (params[:sort] ? params[:sort] : (session[:sort] ? session[:sort] : ""))
    session[:ratings] = (params[:ratings] ? params[:ratings] : (session[:ratings] ? session[:ratings] : Hash[*Movie.ratings_list.map{|r| [r, "1"]}.flatten]))
    redirect_to movies_path(sort: session[:sort], ratings: session[:ratings]) if not params[:sort] or not params[:ratings]
    @movies = Movie.scoped
    @movies = @movies.order(session[:sort]) if session[:sort]
    @movies = @movies.where(rating: session[:ratings].keys) if session[:ratings]
    @all_ratings = Movie.ratings_list
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
