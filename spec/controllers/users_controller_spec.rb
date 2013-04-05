require 'spec_helper'

describe UsersController do
  describe 'upload a profile picture' do

    before :each do
      # stub the filter methods called before each controller method
      @fake_user = mock('User', :id => 1)
      User.should_receive(:find_by_id).and_return @fake_user
      controller.should_receive(:set_is_mine)
    end

    it 'should save a profile picture successfully' do
      @fake_user.should_receive(:attributes=)
      @fake_user.should_receive(:save).and_return(true)

      post :update_profile_picture, {:uid => 1}
      response.should redirect_to profile_path
      flash[:notice].should == "Profile picture updated successfully"
    end

    it 'should fail at saving a profile picture' do
      @fake_user.should_receive(:attributes=)
      @fake_user.should_receive(:save).and_return(false)

      post :update_profile_picture, {:uid => 1}
      response.should redirect_to edit_profile_path
      flash[:error].should == "Profile picture update not successful; please make sure you have chosen a valid image filetype"
    end
  end

  describe 'delete a profile picture' do
    before :each do
      # stub the filter methods called before each controller method
      @fake_user = mock('User', :id => 1)
      User.should_receive(:find_by_id).and_return @fake_user
      controller.should_receive(:set_is_mine)
    end

    it 'should save a profile picture successfully' do
      @fake_user.stub!(:avatar).and_return(@fake_user)
      @fake_user.should_receive(:avatar=).and_return(@fake_user)
      @fake_user.should_receive(:destroy)
      @fake_user.should_receive(:save)

      post :destroy_profile_picture, {:uid => 1}
      response.should redirect_to profile_path
    end
  end

end
