require 'rails_helper'

RSpec.describe Movie do
  describe "call with_director" do
    it "returns movies with the same director" do
      Movie.delete_all
      movie1 = { :title => "movie with director 1", :rating => "R", :director => "director1" }
      movie2 = { :title => "movie with director 2", :rating => "PG", :director => "director1" }
      Movie.create(movie1)
      Movie.create(movie2)

      result = Movie.with_director("director1")
      expect(result.find { |movie| movie[:title] == "movie with director 1" }).to_not be_nil
      expect(result.find { |movie| movie[:title] == "movie with director 2" }).to_not be_nil
    end

    it "doesn't return movies by different directors" do
      Movie.delete_all
      movie1 = { :title => "movie with director 1", :rating => "R", :director => "director1" }
      movie2 = { :title => "movie with director 2", :rating => "PG", :director => "director2" }
      Movie.create(movie1)
      Movie.create(movie2)

      result = Movie.with_director("director1")
      expect(result.find { |movie| movie[:title] == "movie with director 1" }).to_not be_nil
      expect(result.find { |movie| movie[:title] == "movie with director 2" }).to be_nil
    end
  end
end