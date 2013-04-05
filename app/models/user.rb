  class User < ActiveRecord::Base

  attr_accessible :uid, :name, :email, :school, :major, :gradyear, :aboutme, :admin, :avatar, :avatar_file_name

  validates :email, :presence => true, :uniqueness => true, :email_format => {:message => "is not in a valid format!"}
  validates :school, :presence => true

  belongs_to :school
  has_and_belongs_to_many :projects, :uniq => true

  # User deletion causes all created projects to be destroyed
  has_many :created_projects, :class_name => 'Project', :foreign_key => "creator_id", :dependent => :destroy
  has_many :comments, :dependent => :destroy

  # for Paperclip file gem
  has_attached_file :avatar,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :bucket => "cet-aii"
  
  image_types = ['image/png', 'image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/tiff', 'image/x-png']
  validates_attachment_content_type :avatar, :content_type => image_types

  def self.find_or_create_from_auth_hash(auth_hash)
    # create a new user or retreive the user if he already exists
    @user = User.find_by_uid(auth_hash[:uid])
    if @user.nil?
      #TODO: once multiple schools are registered with CET, School field should be set dynamically. For now, default to Berkeley.
      @user = User.create!(:uid => auth_hash[:uid], :name => auth_hash[:info][:name], :email => auth_hash[:info][:email], :school => School.find_by_uri('berkeley'), :admin => false, :avatar => nil)
    end
    return @user
  end

  def self.search(search)
    if search != nil
      find(:all, :conditions => ['lower(email) LIKE ? OR lower(name) LIKE ?', "%#{search}%".downcase, "%#{search}%".downcase])
    end
  end

end
