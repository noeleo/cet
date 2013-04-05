Feature: searching for a user or event or project
	
	As a user
	So that I can search for users, events or projects
	I want to implement a search bar

Background: student is logged into ai2
  Given the following schools exist:
  | name      | uri      |
  | Berkeley  | berkeley |

  And the following users exist:
  | name      | email             | school   | admin	|
  | Breh      | breh@berkeley.edu | berkeley | false	|
  | Bro 	    | bro@berkeley.edu  |	berkeley | false	|
  | admin      | admin@berkeley.edu   | berkeley  | true    |

  Given I am logged in as "bro@berkeley.edu"
  And I am on the new project page
  When I fill in "title" with "Broseph Project"
  And I fill in "description" with "Here is the description for my project"
  And I press "Create Project"
  Then I should see "Broseph Project"

Scenario: Search for a project
  Given I am on the Berkeley page
  Then I should see "Broseph Project"
  When I fill in "b" for "search"
  And I press "search_submit"
  Then I should see "Broseph Project"
  And I should see "Here is the description for my project"
  And I should see "Bro"

Scenario: Search for a user
  Given I am on the Berkeley page
  When I fill in "search" with "Breh"
  And I enter my search terms
  Then I should see "breh@berkeley.edu"

Scenario: Search for an event
  Given I am logged in as "admin@berkeley.edu"
  Given I am on the Events page
  When I fill in "name" with "event name"
  And I fill in "description" with "event description"
  And I fill in "location" with "event location"

  And I select "2012" from "event_startTime_1i"
  And I select "November" from "event_startTime_2i"
  And I select "20" from "event_startTime_3i"
  And I select "12 AM" from "event_startTime_4i"
  And I select "00" from "event_startTime_5i"

  And I select "2012" from "event_endTime_1i"
  And I select "November" from "event_endTime_2i"
  And I select "20" from "event_endTime_3i"
  And I select "12 AM" from "event_endTime_4i"
  And I select "30" from "event_endTime_5i"
  
  And I press "Create Event"
  Then I should see "Upcoming Events"
  And I should see "event name"

  Given I am on the Berkeley page
  When I fill in "search" with "event name"
  Then I should see "event description"
  And I should see "event name"
  And I should see "November"

Scenario: No results come up (sad path)
  Given I am on the Berkeley page
  When I fill in "search" with "BASDFWEADSFWEADSFWERASDFWEA"
  And I enter my search terms
  Then I should see "Your search did not find any matches. Try a different search term!"