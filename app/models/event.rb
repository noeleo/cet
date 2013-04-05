class Event < ActiveRecord::Base
  attr_accessible :description, :name, :location, :startTime, :endTime, :school

  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :startTime, :presence => true
  validates :endTime, :presence => true

  belongs_to :school

  def self.search(search)
    if search != nil
      find(:all, :conditions => ['lower(name) LIKE ? OR lower(location) LIKE ? or lower(description) LIKE ?', "%#{search}%".downcase, "%#{search}%".downcase, "%#{search}%".downcase])
    end
  end

end
