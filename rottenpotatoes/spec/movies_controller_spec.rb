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

RSpec.describe MoviesController, :type => :controller do
  describe "GET the index page" do
    it "renders the index page" do
      Movie.delete_all
      movie1 = { :id => 1, :title => "movie1", :rating => "R", :director => "director1" }
      movie2 = { :id => 2, :title => "movie2", :rating => "R", :director => "director1" }
      Movie.create(movie1)
      Movie.create(movie2)
      get :index
      expect(response).to render_template("movies/index")
    end
  end

  describe "GET the detail page for a movie" do
    it "renders the show page" do
      Movie.delete_all
      movie1 = { :id => 1, :title => "movie1", :rating => "R", :director => "director1" }
      Movie.create(movie1)
      get :show, :id => 1
      expect(response).to render_template("movies/show")
    end
  end

  describe "GET the new page" do
    it "renders the new page" do
      get :new
      expect(response).to render_template("movies/new")
    end
  end

  describe "GET the edit page" do
    it "renders the edit page" do
      Movie.delete_all
      movie1 = { :id => 1, :title => "movie1", :rating => "R", :director => "director1" }
      Movie.create(movie1)
      get :edit, :id => 1
      expect(response).to render_template("movies/edit")
    end
  end

  describe "POST a new movie" do
    it "redirects to the index page" do
      Movie.delete_all
      post :create, :movie => {:id => 1, :title => "movie1", :rating => "R", :director => "director1"}
      expect(response).to redirect_to movies_path
    end
  end

  describe "PUT an existing movie" do
    it "redirects to the show page" do
      Movie.delete_all
      movie1 = { :id => 1, :title => "movie1", :rating => "R", :director => "director1" }
      Movie.create(movie1)
      post :update, :id => 1, :movie => {:id => 1, :title => "movie1_updated", :rating => "R", :director => "director1"}
      expect(response).to redirect_to movie_path(1)
    end
  end

  describe "DELETE an existing movie" do
    it "redirects to the index page" do
      Movie.delete_all
      movie1 = { :id => 1, :title => "movie1", :rating => "R", :director => "director1" }
      Movie.create(movie1)
      delete :destroy, :id => 1
      expect(response).to redirect_to movies_path
    end
  end

end