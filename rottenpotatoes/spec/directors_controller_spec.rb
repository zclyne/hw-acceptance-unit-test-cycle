require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe DirectorsController, :type => :controller do

  describe "GET search a movie with a director" do
    it "returns the similar movies" do
      Movie.delete_all
      # create a movie with director
      movie = { :id => 1, :title => "movie with director", :rating => "R", :director => "director1" }
      Movie.create(movie)
      get :search, :movie_id => 1
      expect(response).to render_template("directors/similar_movies")
      puts response
    end
  end
  describe "GET search a movie without a director" do
    it "renders the index page" do
      Movie.delete_all
      movie = { :id => 2, :title => "movie without director", :rating => "R" }
      Movie.create(movie)
      get :search, :movie_id => 2
      expect(response).to redirect_to "/movies"
    end
  end

end