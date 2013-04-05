require 'spec_helper'

describe Event do
  
  describe 'create a new event' do
    before :each do
      info = {:name => "steven", :email => "a@gamil.com"}
      auth_hash = {:uid => 1, :info => info} 
      @user = User.find_or_create_from_auth_hash(auth_hash)
      @user.admin = true
    end
    

  end

end
