Feature: Viewing an event
	 
	 As a user
	 So that I know about upcoming events
	 I want events to be visible from my school's home page

Background: the user is logged in

  Given the following schools exist:
  | name       | uri      |
  | Berkeley   | berkeley |

  And the following users exist:
  | name       | email             		| school    | admin		|
  | name       | bruh@berkeley.edu 		| berkeley  |	false 	|
  | admin      | admin@berkeley.edu   | berkeley  |	true 		|

  And the following events exist:
  | name       | description                      |
  | event name | event description                |

Scenario: View an event
	  
	  Given I am logged in as "bruh@berkeley.edu"
	  And I am on the Berkeley page
	  Then I should see "event name"