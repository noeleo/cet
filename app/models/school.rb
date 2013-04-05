class School < ActiveRecord::Base

  attr_accessible :name, :location, :uri

  validates :name, :presence => true, :uniqueness => true
  validates :location, :presence => true
  validates :uri, :presence => true, :uniqueness => true, :format => { :with => /^[a-z]+$/ }

  has_many :users
  has_many :projects
  has_many :events

end
