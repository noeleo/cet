#README#
This project is a prototype for the Applied Innovation Institute's new website for student collaboration. Information about the Applied Innovation Institute (AII) can be found at www.bmic.org. 
This readme will describe all of the entities of this project, and assist in the transition of code ownership, specifically noting where code needs change for production.
This web application was created by Doug Wreden (douglas.wreden@gmail.com), Simon Janpanah (sjanpanah@gmail.com), Noel Moldvai (noelmoldvai@gmail.com), Barrett Glasauer (bglasauer@gmail.com), and Steven Farberov (farberovs@yahoo.com). 

The goal of this website is to provide a hub for students to collaborate and compete in entrepreneurial endeavors. The site hopes to foster collaboration on projects and participation in school-run competitions, and will provides a means for students across school communities to work with one another on entrepreneurial ideas.
The best way to begin understanding the project is to take a look around the website, which as of this writing is hosted at morning-sands-2053.herokuapp.com (a temporary url for development purposes). 
Additionally, a screencast showing basic use of the website can be found here: *YOUTUBE LINK NEEDED*

##DATABASE ENTITIES##
###Schools:###
On a high-level, a school entity is meant to center around the activities of that particular campus community and provide a hub for students to seek out opportunities for involvement. A school entity has users, projects, and events associated with it; the school homepage displays all projects created by users of that school and events created by the admin of the school. As a user, you will be tied to a particular school, and any projects that you make will automatically be associated with that school. However, you can visit other schools' homepages and view other student's projects, thus allowing you to communicate with those students if so desired. In general, schools are intended to be relatively modular, with a certain amount of cross-interaction between school users.

Currently, Berkeley is the only supported school, which simply means that a single school record exists in the database, and all created users are automatically tied to this school. To add a new school, update the seed file (*/db/seeds.rb*) to create a new school object, and then update the login code to reflect the association of users with that new school (in */app/models/user.rb#find_or_create_from_auth_hash).

###Users:###
A user represents a student or admin for a particular school. A user can create create and collaborate on projects, which is the primary means in which students will interact with the website. 
Each user, when instantiated, has its school set to Berkeley by default; see */app/models/user.rb:19*, but this can be changed in the login scheme, as mentioned in the Schools section.

Users should be able to login into AII through their school's individual authentication system. For example, UC Berkeley students would login through the Calnet authentication system. Omniauth, as mentioned in the login section, will take care of this login and return any student information to the website. In this way, all users will be able to login to the site without creating an additional account.

In the database, each user object will have both an id and a uid. The id is simply the object's id in the database. The uid is a string that represents the name of the user *as recognized by the 3rd party login provider*. For instance, UC Berkeley might track a student by his email address (say, robert_smith@berkeley.edu). Therefore, when that student logs in, the uid provided by omniauth will be 'robert_smith@berkeley.edu'. The use of the uid is necessary for the website to recognize users from particular schools.

###Admin Users###
Admin users have all the privileges of a normal user, but can additionally create events for their school and delete any projects and comments associated with their school. An admin user would hypothetically be a professor who is overseeing the projects and events of the school community.
Admin users are denoted by an admin flag - to create new admin users, simply set the admin flag to true in the database. Ideally, with each new school created a number of admin users will be created alongside it, who can then add additional admin users in the future.

###Projects:###
On a high-level, projects represent any sort of entrepreneurial idea or endeavor - they could be a startup idea, a proposal for a new company, a codebase for a phone application, etc. Projects are created and maintained by student collaborators, and can contain basic information, documents, and comments. Each project is forward facing (anyone can view the project and its progress), but only project collaborators can edit the project.

In the database, each project has a creator, representing the user that actually formed the project. Additionally, it has user collaborators, which are all of the users that have edit privileges for the project.

###Events:###
On a high-level, events are competitions that schools can host and that students participate in. The events system is not fully fleshed out as of this writing, but can be easily augmented using the existing Events entity.

Event objects are created by admin users in the "Manage Events" page. Each event will be automatically associated with the school of the admin-user creating it. Possibilities for expanding events would include the ability for students to sign their projects up for specific events, and then have that event page list all the involved projects.

###Documents and Profile Pictures:###
These are the file storage entities for projects/users. Files are stored in the cloud on Amazon's S3 using the paperclip and aws-sdk gems. At the time of the writing of this readme, Simon's personal aws account is tied to this project; at the handover point, I will disable my access keys. Change them to allow the filesystem to store files correctly. **AWS account keys are stored in *config/s3.yaml***. If AWS S3 is undesirable, remove the arguments to the "has attached file" association in the model, and files will be stored locally instead. Furthermore, **the unique s3 bucket must be specified** in the 'document' and 'profile\_picture' models files, specifically in the has\_attached\_file\_ association.

###Comments:###
Comments are associated with a project and be created by any user, collaborator or not. On a high-level, this allows outside users to give feedback on students' projects, and allows collaborators to comment on the progress of any work.

##Frontend##
The focus of this project was on the backend of the code, as AII plans on having a professional graphic designer follow up on our work by redesigning the look of the website. Therefore the amount of frontend work done was minimal. We used Twitter's bootstrap for CSS and the stylesheets can be found in */app/assets/stylesheets*. Additionally, we used Erb for our html work.

##General Notes##
*permissions*: Only users who should be allowed to make modifications are allowed to do so. For example, a non-collaborator for a project cannot access or upload/delete files, add/delete comments, or edit any project-related information - some of the buttons won't even show up, and for those that do, nothing happens when clicked and "permission denied" is flashed.

*login*: We used the Omniauth gem for authentication, which allows single sign on through 3rd party providers. At the time of this writing, only a local login scheme is implemented with omniauth, but additional strategies such as CAS can be easily added. Instructions on adding new omniauth providers to the project can be found here:
https://github.com/intridea/omniauth
As an example for adding new school logins: to add Stanford students to the login scheme, the AII administration should talk to Stanford's student authentication administrators and have the AII website added to their authentication list. With this permission, the website can simply use omniauth to direct students to the Stanford authentication page, have students login there, and then receive an authentication hash of student information back in return. This allows for single-sign on, and prevents the need for user accounts and passwords to be stored within the website. 

*testing*: Testing was done using Cucumber and Rspec, whose tests can be run with "rake cucumber" and "rake spec", respectively. 




