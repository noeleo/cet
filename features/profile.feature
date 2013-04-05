Feature: the Profile Page on ai2

  As a Cal Student
  So that I can display my information to others and see my projects
  I want to be able to add information to my profile for others to view and see all my projets

Background: the student is logged into ai2

  Given the following schools exist:
  | name       | uri      |
  | Berkeley   | berkeley |

  And the following users exist:
  | name       | email             		| school    | admin		|
  | name       | bruh@berkeley.edu 		| berkeley  |	false 	|
  | bro        | bro@berkeley.edu     | berkeley  | false   |
  | breh       | breh@berkeley.edu     | berkeley  | false   |
  | admin      | admin@berkeley.edu   | berkeley  |	true 		|

  And the following projects exist:
  | title     | description | creator           | collaborators      |
  | Project A | p1          | bro@berkeley.edu  |                    |
  | Project B | p2          | breh@berkeley.edu | bro@berkeley.edu   |
  | Project C | p3          | breh@berkeley.edu |                    |
  | Project D | p4          | bro@berkeley.edu  | breh@berkeley.edu  |
  
	Given I am logged in as "bruh@berkeley.edu"

Scenario: View my profile information
  Given I am on the Berkeley page
  When I follow "Profile"
  Then I should be on the profile page for "bruh@berkeley.edu"
  And I should see "name"
  And I should see "Email"
  And I should see "School"
  And I should see "Major"
  And I should see "About Me"
  And I should see "Graduation Year"
  And I should not see "Active Projects"

Scenario: Edit my profile information (happy path)
  Given I am on the profile page for "bruh@berkeley.edu"
  When I press "Edit Profile"
  Then I should be on the edit profile page for "bruh@berkeley.edu"
  When I fill in "aboutme" with "I'm pretty chill"
  And I press "updateprofile"
  Then I should be on the profile page for "bruh@berkeley.edu"
  And I should see "I'm pretty chill"

Scenario: I should see all my active projects
  Given I am logged in as "bro@berkeley.edu"
  And I am on the profile page for "bro@berkeley.edu"
  Then I should see "Project A"
  And I should see "Project B"
  And I should not see "Project C"
  And I should see "Project D"
  And I should see "1"
  And I should see "2"
