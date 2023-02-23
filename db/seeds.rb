# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'json'

def new_movies
  Movie.destroy_all
  url = "http://tmdb.lewagon.com/movie/top_rated"
  movies = URI.open(url).read
  movie_list = JSON.parse(movies).transform_keys(&:to_sym)
  flims = movie_list[:results].map {|movie|movie.transform_keys(&:to_sym) }
  flims.each do |movie|
    Movie.create!(title: movie[:original_title], overview: movie[:overview], rating: movie[:vote_average], poster_url: movie[:poster_path])
  end
end

p new_movies
