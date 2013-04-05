require 'spec_helper'

describe SessionsController do
  describe 'successfully login with a new user' do
    it 'should recieve find_or_create_from_auth_hash from omniauth' do
      @fake_user = mock('User', :id => '1')
      User.should_receive(:find_or_create_from_auth_hash).and_return(@fake_user)
      
      post :create, {:provider => 'developer'}
    end
  end
end
