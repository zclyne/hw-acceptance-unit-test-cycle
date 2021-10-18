class Movie < ActiveRecord::Base

  def self.with_director(director)
    Movie.where({ director: director })
  end

end
