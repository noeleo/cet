require 'spec_helper'

describe DocumentsController do
  describe 'create a new document' do
    before :each do
      # stub the filter methods called before each documents_controller method
      @fake_user = mock 'User'
      @fake_document = mock('Document', :project= => nil, :updater= => nil)
      @fake_project = mock('Project', :id => 1)
      User.should_receive(:find_by_id).and_return @fake_user
      Project.should_receive(:find_by_id).and_return @fake_project
    end

    it 'should create a document and save' do
      # stub the 'set_can_edit' filter method to set @can_edit as true
      @fake_project.should_receive(:users).and_return @fake_project
      @fake_project.should_receive(:include?).and_return true
      
      @fake_project.should_receive(:documents).and_return @fake_project
      @fake_project.should_receive(:<<).with @fake_document
      @fake_document.should_receive(:save).and_return true
      Document.should_receive(:new).with("hello").and_return @fake_document

      post :create, {:pid => 1, :document => "hello"}
      response.should redirect_to project_path
    end

    it 'should create a document and fail when saving' do
      # stub the 'set_can_edit' filter method to set @can_edit as true
      @fake_project.should_receive(:users).and_return @fake_project
      @fake_project.should_receive(:include?).and_return true
      
      @fake_project.should_receive(:documents).and_return @fake_project
      @fake_project.should_receive(:<<).with @fake_document
      @fake_document.should_receive(:save).and_return false
      Document.should_receive(:new).with("hello").and_return @fake_document
      
      post :create, {:pid => 1, :document => "hello"}
      response.should redirect_to project_path
    end
    
    it 'should throw an error if user doesnt have permission (sad path)' do
      # stub the 'set_can_edit' method to set @can_edit as false
      @fake_project.should_receive(:users).and_return @fake_project
      @fake_project.should_receive(:include?).and_return false
      @fake_user.should_receive(:admin).and_return false

      post :create, {:pid => 1}
      response.should redirect_to project_path
      flash[:error].should =~ /Permission denied.../
    end
  end

  describe 'destroy a document' do
    before :each do
      # stub the filter methods called before each documents_controller method
      @fake_user = mock 'User'
      @fake_document = mock('Document', :project= => nil, :updater= => nil)
      @fake_project = mock('Project', :id => 1)
      User.should_receive(:find_by_id).and_return @fake_user
      Project.should_receive(:find_by_id).and_return @fake_project
    end

    it 'should destroy the document (happy path)' do
      # stub the 'set_can_edit' filter method to set @can_edit as true
      @fake_project.should_receive(:users).and_return @fake_project
      @fake_project.should_receive(:include?).and_return true
      Document.should_receive(:find_by_id).and_return(@fake_document)
      @fake_document.should_receive(:avatar).and_return(@fake_document)
      @fake_document.should_receive(:destroy).twice

      post :destroy, {:pid => 1, :did => 1}
      response.should redirect_to project_path
      flash[:notice].should == "File deleted successfully."
    end

    it 'should throw an error if user doesnt have permission (sad path)' do
      # stub the 'set_can_edit' filter method to set @can_edit as false
      @fake_project.should_receive(:users).and_return @fake_project
      @fake_project.should_receive(:include?).and_return false
      @fake_user.should_receive(:admin).and_return false

      post :destroy, {:pid => 1, :did => 1}
      response.should redirect_to project_path
      flash[:error].should == "Permission denied..."
    end
  end
end
