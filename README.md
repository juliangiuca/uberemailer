# UberEmailer
[Coding exercise](https://github.com/uber/coding-challenge-tools) from Uber.

### What is it?
[See it in action](http://uber-emailer.herokuapp.com/)!

UberEmailer is a simple emailer with failover via Mailgun then Mandrill. It allows
you to send an email from an address of your choosing, to a recipient of your
choosing.  

I approached this by building a super simple Sinatra and Angular app.

### Install
Install the gems:
```
bundle
```
Then boot up the app!
```
rackup
```


### Config
You need either the environment variables, or a .env file with the following:
```
MAILGUN_KEY=ABCD123
MANDRILL_KEY=ABCD1233

```
The API keys can be reached at [Mailgun](https://mailgun.com/cp) and
[Mandrill](https://mandrillapp.com/settings).

N.B. Make sure you don't have "API" as part of the prefix for your Mailgun key.

### Deployment
```
git push heroku master
```

### Testing
```
rspec
```

### If I had more time
* Given this is an exercise in fault tolerance, I would probably put the email
processing into an async queue (like Resque), and handle the errors by re-listing
the job in the queue with an exponential backoff.
* I'd like to add some user feedback when the email is successfully or fails (JS error handling)
* Persist the emails and the response to a database, and tie those entries to a users session.
This would essenailly allow someone to have a history of the emails. Unless the clear their cookies!
* Add HTML to the emails. Pretty easy with TextAngular. Didn't have time =(
* Auth. Make people OAuth in, and lock the "from" to their email address.
* Controller tests to make sure the error handling works when sending fails.


### Other questions
##### The project you chose (departure times, SF movies, email service or food trucks)
Email service in Ruby with Angular and Bootstrap.

##### The technical track you chose (full stack, back-end or front-end)
Full-stack / backend. Angular is fun for simple UI widgetry, but all the heavy lifting is done
in Ruby. A different (entertaining but insecure) way to approach the problem would be to have the Angular app
POST directly to the mail servers.

##### Reasoning behind your technical choices (and level of experience with those)
Ruby is my background, so building and testing is easy. Angular and Bootstrap allow for simple
UI wizardly with minimal effort. Worked in Ruby for ~7+ years.

##### Trade-offs you might have made, anything you left out, or what you might do differently if you were to spend additional time on the project
See the 'If I had more time' section, above.

##### Link to other code you're particularly proud of
The [emailer](https://github.com/juliangiuca/emailer) app is pretty cool, but the code is scrappy
since it's gone through a few iterations. Most of the cool stuff I've written is the property of New Relic.

##### Link to your resume or public profile
[Julian Giuca](https://github.com/juliangiuca)

### License
MIT License
