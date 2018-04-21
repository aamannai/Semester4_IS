## 67-272: Chess Camp Phase 3 Starter Code ##

This is a basic solution for the course project in 67-272: Application Design and Development.  This repo contains a solution only to Phase 2 of the project and can be used to start phases 3 and 4.

After cloning this repo, switch into the project directory and remove the reference to `origin` with the following:

```
  git remote rm origin
```

This will stop you from accidentally trying to push changes to Prof. H's repo (which won't be accepted).  Now it is recommended that instead you set up a connection to your remote repository on darkknight soon and begin saving your code there early in your development.  There is no limit on the number of times you can commit code to the remote repository and remember that committing to your local repository does not automatically mean the remote repository has been updated.

After this, run the `bundle install` command to ensure you have all the needed gems and then create the database with `rake db:migrate`.  If you want to populate the system with fictitious, but somewhat realistic data (similar to the data given in the spreadsheets in phase 1), you can run the `rake db:populate` command.  The populate script will create a series of curriculums, instructors and over 35 camps

Many objects are created with some element of randomness so you will get slightly different results each time it is run.  However, instructors and users are fixed.  If there were any users in this phase, all the users in the system have a password of 'secret'.  In terms of users there are two admins (Alex and Mark) and five instructor-level users (our five Head TAs).  The username for each will be their first name in all lowercase.

To run the controller tests, simply type `rails test:controllers` on the command line.  Initially they should all fail since there are no controllers in the code yet.

To run the cucumber tests, first be sure the test database is set up properly with run `rake db:test:prepare`.  After that, simply type `bundle exec cucumber` on the command line and the tests will run.  It is strongly recommended that you get your controller tests passing before attempting to pass cucumber tests.

Instructions for what needs to be done in this phase of the project can be found in the project write-ups found on the [67-272 course site](http://67272.cmuis.net/projects/).