Feature: Logging in as an admin

  As an admin
  So that I can notify students about upcoming events
  I want to have edit, delete, and add access to my school's upcoming events

Background: the user is logged in as an admin

  Given the following schools exist:
  | name       | uri      |
  | Berkeley   | berkeley |

  And the following users exist:
  | name       | email             		| school    | admin		|
  | name       | bruh@berkeley.edu 		| berkeley  |	false 	|
  | admin      | admin@berkeley.edu   | berkeley  |	true 		|
  
  And the following events exist:
  | name       | description                      |
  | test event | this is the test event           |

Scenario: Logging in as admin ( Happy )
	  Given I am logged in as "admin@berkeley.edu"
  	Given I am on the Berkeley page
  	Then I should see "Manage Events"

Scenario: Logging in as admin ( Sad )
	  Given I am logged in as "bruh@berkeley.edu"
  	Given I am on the Berkeley page
  	Then I should not see "Manage Events"

Scenario: Create an event ( Happy )
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
    Then I should see "event name"

Scenario: Create an event ( Sad )
    Given I am logged in as "admin@berkeley.edu"
    Given I am on the Events page
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
    And I should not see "event description"

Scenario: Edit an event ( happy )

    Given I am logged in as "admin@berkeley.edu"
    Given I am on the Events page
    And I press "Edit"
    And I fill in "description" with "new description"
    And I press "Update Event"
    Then I should see "Upcoming Events"
    And I should see "new description"

Scenario: Edit an event ( sad )

    Given I am logged in as "admin@berkeley.edu"
    Given I am on the Events page
    And I press "Edit"
    And I fill in "description" with "new description"
    And I fill in "name" with ""
    And I press "Update Event"
    Then I should see "Upcoming Events"
    And I should see "One or more fields were left blank, please try again."

Scenario: Delete an event
    Given I am logged in as "admin@berkeley.edu"
    Given I am on the Events page
    And I press "Delete"
    Then I should see "Upcoming Events"
    And I should not see "event name"
