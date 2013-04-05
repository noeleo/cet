Feature: Projects in ai2

	As an entrepreneur
	So that I can collaborate on projects with other users
	I want to create, edit and delete projects as well as manage comments on them and add collaborators

Background: Student is logged into ai2
  Given the following schools exist:
  | name       | uri      |
  | Berkeley   | berkeley |

  And the following users exist:
  | name       | email             		| school    | admin		|
  | Bruh       | bruh@berkeley.edu 		| berkeley  |	false 	|
  | Bro        | bro@berkeley.edu     | berkeley  |	false		|

  And the following projects exist:
  | title     | description | creator           | collaborators |
  | Project 1 | p1          | bruh@berkeley.edu |               |
  | Project 2 | p2          | bro@berkeley.edu  |                   |
  | Project 3 | p3          | bro@berkeley.edu  | bruh@berkeley.edu |
  

Scenario: Create a new project (happy path)
  Given I am logged in as "bruh@berkeley.edu"
  And I am on the new project page
  When I fill in "title" with "My New Project"
  And I fill in "description" with "Here is the description for my project"
  And I press "Create Project"
  #Then I should be on the create project page--need to specify id
  Then I should see "My New Project"
  And I should see "Here is the description for my project"

Scenario: Create a new project (sad path)
  Given I am logged in as "bruh@berkeley.edu"
  And I am on the new project page
  When I fill in "description" with "Here is the description for my project"
  And I press "Create Project"
  Then I should be on the new project page
  And I should see "Sorry, something went wrong with creating a new project."  

Scenario: Successfully edit my project
  Given I am logged in as "bruh@berkeley.edu"
  And I am on the edit project page for "Project 1"
	When I fill in "project_title" with "Changed Project Name"
	And I fill in "project_description" with "My new description is chill."
  And I press "Update Project"
  Then I should be on the project page for "Changed Project Name"
  And I should see "Changed Project Name"
  And I should see "My new description is chill."

Scenario: Unsuccessfully edit my project
  Given I am logged in as "bruh@berkeley.edu"
  And I am on the edit project page for "Project 1"
  When I fill in "project_title" with ""
	And I fill in "project_description" with "Here is the description for my project"
  And I press "Update Project"
  Then I should be on the edit project page for "Project 1"
  And I should see "Sorry, something went wrong with editing this project."

Scenario: Delete a project
  Given I am logged in as "bruh@berkeley.edu"
  And I am on the edit project page for "Project 1"
  When I press "Delete Project"
  Then I should be on the Berkeley page
  And I should see "Successfully deleted Project 1"
  Given I am on the profile page for "bruh@berkeley.edu"
  Then I should not see "Project 1"

Scenario: see the project on the berkeley homepage

  Given I am logged in as "bruh@berkeley.edu"
  And I am on the Berkeley page
  Then I should see "Project 1"

Scenario: add a comment
  Given I am logged in as "bruh@berkeley.edu"
  And I am on the project page for "Project 1"
  When I fill in "new_comment" with "This is a new comment."
  And I press "Add Comment"
  Then I should be on the project page for "Project 1"
  And I should see "This is a new comment."

Scenario: see comments in reverse chronological order
  Given I am logged in as "bruh@berkeley.edu"
  And I am on the project page for "Project 1"
  When I fill in "new_comment" with "Comment one"
  And I press "Add Comment"
  Then I should be on the project page for "Project 1"
  When I fill in "new_comment" with "Comment two"
  And I press "Add Comment"
  Then I should be on the project page for "Project 1"
  And I should see "Comment two" before "Comment one"

Scenario: delete comments as a project collaborator
  Given I am logged in as "bruh@berkeley.edu"
  And I am on the project page for "Project 1"
  When I fill in "new_comment" with "i hate this comment"
  And I press "Add Comment"
  Then I should be on the project page for "Project 1"
  And I should see "i hate this comment"
  Given I press "Delete Comment"
  Then I should be on the project page for "Project 1"
  And I should not see "i hate this comment"

Scenario: Successfully add collaborator to project 1
  Given I am logged in as "bruh@berkeley.edu"
  When I follow "Project 1"
  And I press "Edit Collaborators"
  And I fill in "collaborator" with "bro@berkeley.edu"
  And I press "Add Collaborator"
  Then I should be on the edit collaborators page for "Project 1"
  And I should see "Collaborator added!"
  And I should see "bro@berkeley.edu"

Scenario: Fail to add inexistent collaborator to project 1
  Given I am logged in as "bruh@berkeley.edu"
  When I follow "Project 1"
  And I press "Edit Collaborators"
  And I fill in "collaborator" with "idontexist@berkeley.edu"
  And I press "Add Collaborator"
  Then I should be on the edit collaborators page for "Project 1"
  And I should see "Invalid collaborator!"

Scenario: Fail to add duplicate collaborator to project 2
  Given I am logged in as "bro@berkeley.edu"
  When I follow "Project 2"
  And I press "Edit Collaborators"
  And I fill in "collaborator" with "bruh@berkeley.edu"
  And I press "Add Collaborator"
  Then I should be on the edit collaborators page for "Project 2"
  When I fill in "collaborator" with "bruh@berkeley.edu"
  And I press "Add Collaborator"
  Then I should be on the edit collaborators page for "Project 2"
  And I should see "Invalid collaborator!"

Scenario: Delete collaborator
  Given I am logged in as "bro@berkeley.edu"
  When I follow "Project 3"
  And I press "Edit Collaborators"
  And I press delete collaborator "bruh@berkeley.edu"
  Then I should be on the edit collaborators page for "Project 3"
  And I should see "Collaborator deleted!"
  And I should not see "bruh@berkeley.edu"
