# Step definitions for CET

# Setup
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /the following schools exist/ do |schools_table|
  schools_table.hashes.each do |school|
    s = School.new
    s.name = school[:name]
    s.location = "test"
    s.uri = school[:uri]
    s.save!
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    u = User.new
    u.name = user[:name]
    u.email = user[:email]
    u.uid = user[:email]
    u.school = School.find_by_uri(user[:school])
		u.admin = user[:admin]
    u.save!
  end
end

Given /the following projects exist/ do |projects_table|
  projects_table.hashes.each do |project|
    p = Project.new
    p.title = project[:title]
    p.description = project[:description]
    p.creator = User.find_by_email(project[:creator])
    p.school_id = User.find_by_email(project[:creator]).school
    p.users << User.find_by_email(project[:creator])
    project[:collaborators].split.each do |collaborator|
      p.users << User.find_by_email(collaborator)
    end
    p.save!
  end
end

Given /the following events exist/ do |events_table|
  events_table.hashes.each do |event|
    e = Event.new
    e.name = event[:name]
    e.description = event[:description]
    e.startTime = DateTime.now
    e.endTime = DateTime.now + 2.hours
    e.school_id = 1
    e.save!
  end
end

When /^I press delete collaborator "(.*)"$/ do |email|
  step %Q{I press "delete_#{User.find_by_email(email).id}"}
end

# Make sure that this user has been created in the cucumber Background!
Given /^I am logged in as "(.*)"$/ do |email|
  step %Q{I am on the login page}
  step %Q{I fill in "name" with "name"}
  step %Q{I fill in "email" with "#{email}"}
  step %Q{I press "Sign In"}
end

Then /^I should see "(.*)" before "(.*)"$/ do |e1, e2|
  page.body.should =~ /#{e1}.*#{e2}/m
end

When /^I enter my search terms$/ do
  click_button("search_submit")
end

#################
##################

# for selecting login
Capybara.add_selector(:element) do
  xpath { |locator| "//*[normalize-space(text())=#{XPath::Expression::StringLiteral.new(locator)}]" }
end

#class Capybara::XPath
#  class << self
#   def element(locator)
#     append("//*[normalize-space(text())=#{s(locator)}]")
#   end
# end
#end

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

When /^I click "(.*)"$/ do |locator|
  #msg = "No element could be found BITCH"
  #locate(:xpath, Capybara::XPath.element(locator), msg).click
  find(:xpath, XPath::HTML.content(locator)).click
end    



