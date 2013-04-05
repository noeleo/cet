# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      home_path

    when /^the login page$/
      login_path

    when /^the Berkeley page$/
      school_path('berkeley')

    when /^the Events page$/
      events_path('berkeley')

    when /^the new project page$/
      new_project_path

    when /^the edit collaborators page/
      ans = /^the edit collaborators page for "(?<title>.*)"$/.match(page_name)
      p = Project.find_by_title(ans[:title])
      edit_collaborators_path(p.id)
    
    when /^the profile page for/
      ans = /^the profile page for "(?<email>.*)"$/.match(page_name)
      u = User.find_by_email(ans[:email])
      profile_path(u.id)

    when /^the edit profile page for/
      ans = /^the edit profile page for "(?<email>.*)"$/.match(page_name)
      u = User.find_by_email(ans[:email])
      edit_profile_path(u.id)

    when /^the project page for/
      ans = /^the project page for "(?<title>.*)"$/.match(page_name)
      p = Project.find_by_title(ans[:title])
      project_path(p.id)

    when /^the edit project page for/
      ans = /^the edit project page for "(?<title>.*)"$/.match(page_name)
      p = Project.find_by_title(ans[:title])
      edit_project_path(p.id)

    when /^the messages page/
      ans = /^the messages page for "(?<email>.*)"$/.match(page_name)
      u = User.find_by_email(ans[:email])
      messages_path(u.id)

    when /^"(.*)"$/
      page_name

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
