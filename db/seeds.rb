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
  Bookmark.destroy_all
  Movie.destroy_all
  url = "http://tmdb.lewagon.com/movie/top_rated"
  movies = URI.open(url).read
  movie_list = JSON.parse(movies).transform_keys(&:to_sym)
  flims = movie_list[:results]
  flims.each do |movie|
    base_poster_url = "https://image.tmdb.org/t/p/w500"
    Movie.create!(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
      rating: movie['vote_average']
    )
  end
end

p new_movies
