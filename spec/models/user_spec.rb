
require 'spec_helper'

describe User do

  describe 'find or create a user' do
    before :each do
      @fake_auth_hash = mock 'auth_hash'
      @fake_auth_hash.stub!(:[]).with(:uid).and_return('1')
      @fake_auth_hash.stub!(:[]).with(:info).and_return({:name => "test", :email => "test@berkeley.edu"})
      @fake_user = mock 'user'
      @fake_nil_user = mock 'nil_user'
    end
    it 'should find an existing user' do
      User.should_receive(:find_by_uid).with('1').and_return @fake_user
      User.find_or_create_from_auth_hash(@fake_auth_hash)
    end
    it 'should create a new user' do
      User.should_receive(:find_by_uid).with('1').and_return @fake_nil_user
      @fake_nil_user.should_receive(:nil?).and_return(true)
      User.should_receive(:create!).and_return @fake_user
      User.find_or_create_from_auth_hash(@fake_auth_hash)
    end
  end

end
