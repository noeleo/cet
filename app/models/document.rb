class Document < ActiveRecord::Base
  attr_accessible :avatar, :description, :updater
  
  #associations
  belongs_to :project
  belongs_to :updater, :class_name => "User", :foreign_key => "updater_id"

  # Code for Paperclip file gem
  has_attached_file :avatar,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :bucket => "cet-aii"
  
  validates_attachment_presence :avatar
end
