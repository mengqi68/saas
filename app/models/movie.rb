class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def self.ratings_list
  	all.map{|m| m.rating}.uniq
  end
end
