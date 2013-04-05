# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

s = School.create(name: 'Berkeley', location: 'Berkeley, CA', uri: 'berkeley')

# Users
u1 = User.create!(name: 'Homer Simpson', uid: 'homer@berkeley.edu', email: 'homer@berkeley.edu', school: s, admin: false)
u2 = User.create!(name: 'Marge Simpson', uid: 'marge@berkeley.edu', email: 'marge@berkeley.edu', school: s, admin: false)
u3 = User.create!(name: 'Lisa Simpson', uid: 'lisa@berkeley.edu', email: 'lisa@berkeley.edu', school: s, admin: false)
u4 = User.create!(name: 'Bart Simpson', uid: 'bart@berkeley.edu', email: 'bart@berkeley.edu', school: s, admin: false)
u5 = User.create!(name: 'testAdmin', uid: 'testAdmin@berkeley.edu', email: 'testAdmin@berkeley.edu', school: s, admin: true)

# Projects
p1 = Project.create!(title: 'The New Facebook', description: 'We will be making a new version of facebook, except where people post their thoughts on the current weather instead of statuses. Also, the app will sell users personal information to Samalian Pirates.', creator: u1, school: s)
p2 = Project.create!(title: 'Chinese Sushi', description: 'Have you ever thought to yourself that sushi would be better with orange chicken inside of it? Well think no longer, because Chinese Sushi is a company aimed at fuzing two foods that make absolutely no sense together. Eel and chowmein roll? Done. Sweet and sour Tiger roll? Zesty. Chicken feet inside a California roll? Serendipitous. We are the Bobby Flay of China.', creator: u2, school: s)
p3 = Project.create!(title: 'Space Pizza Delivery', description: 'Our company strives to seamlessly merge West Coast Pizza and the planet Jupiter. By partnering with NASA, we have created a service that allows users to have pizza delivered to different planets for an affordable price, all under 200 dollars. No longer will people be unable to satisfy their drunchies when they drink too much and then black in on Jupiter! Open late.', creator: u3, school: s)
p4 = Project.create!(title: 'Whats in my Stomach?', description: 'We are inventing technology that scans a persons colon, and then posts the results of that scan in real-time to their Facebook wall. No longer will you wonder what food is currently being processed in your friends digestive tract!', creator: u4, school: s)

p1.users << u1
p2.users << u2
p3.users << u3
p4.users << u4

print "\n\n\n Projects seeded! \n\n\n"

# Events
startTime = DateTime.now
endTime = DateTime.now
e1 = Event.create!(name: 'University Mobile Challenge', 
			description: "Students from around the world compete to invent the mobile app of the future! There will be sponsors and prizes!",
			startTime: startTime,
			endTime: endTime,
			location: "Stanford Medical Center",
			school: s
)
e2 = Event.create!(name: 'CSUA Hackathon', 
			description: "Come participate in UC Berkeley's semesterly Hackathon! Food, prizes and coding! What's not to love? Sign up now at csua.org/hackathon.",
			startTime: startTime,
			endTime: endTime,
			location: "UC Berkeley, Wozniak Lounge",
			school: s
)

# Comments
c1 = Comment.create!(text: 'I cant wait to see the finished product. Its going to rock the world.', user: u2, project: p1)
c2 = Comment.create!(text: 'Have you guys uploaded the excel docs yet? Super crucial.', user: u3, project: p1)
c3 = Comment.create!(text: 'I am a banana.', user: u4, project: p1)
c4 = Comment.create!(text: 'Hey guys, check out changes I made to the description.', user: u1, project: p1)
c5 = Comment.create!(text: 'Looks phenomenal. I love sushi.', user: u4, project: p2)
c6 = Comment.create!(text: 'Are you guys looking for additional software engineers?', user: u1, project: p2)
c7 = Comment.create!(text: 'v1.0 to be coming out soon! Ill keep people posted with more info.', user: u2, project: p2)

# Collaborators

