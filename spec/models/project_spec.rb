require 'spec_helper'

describe Project do

  describe 'add a collaborator' do
    
    it 'should add a user to the list of users' do
      @fake_user = User.new
      @fake_project = Project.new(:title => "test_project", :description => "test_description")
      @fake_project.add_collaborator(@fake_user)
      @fake_project.users should_not == nil
    end
  end
end

