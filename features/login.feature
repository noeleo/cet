Feature: login to the site

  As a student entrepreneur
  So that I can access the ai2 website
  I want to login to the site with my student credentials

Background:
	Given the following schools exist:
	| name		| uri		|
	| Berkeley	| berkeley	|
	Given the following users exist:
	| name	| email				| school	| admin |
	| test	| test@berkeley.edu	| berkeley	| false |
  Given I am on the home page
  When I press "Login"
  Then I should be on the login page

Scenario: log in as new user
  When I fill in "name" with "Noeleo"
  And I fill in "email" with "noelmoldvai@berkeley.edu"
  And I press "Sign In"
  Then I should see "Edit Profile"
  And I should see "Name"

Scenario: log in as existing user
  When I fill in "name" with "test"
  And I fill in "email" with "test@berkeley.edu"
	And I press "Sign In"
	Then I should see "test"
	And I should see "test@berkeley.edu"

Scenario: log in with an invalid email
	When I fill in "name" with "Doug"
	And I fill in "email" with "invalid email"
	And I press "Sign In"
	Then I should be on the login page
	And I should see "Please use a valid email address!"
