class Comment < ActiveRecord::Base
  attr_accessible :text, :user, :project

  belongs_to :project
  belongs_to :user
end
