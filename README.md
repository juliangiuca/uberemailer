# UberEmailer
[Coding exercise](https://github.com/uber/coding-challenge-tools) from Uber.

### What is it?
A simple emailer with failover via Mailgun then Mandrill. It allows
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
* I'd like to add some user feedback when the email is successfully or fails
* Persist the emails and the response to a database, and tie those entries to a users session.
This would essenailly allow someone to have a history of the emails. Unless the clear their cookies!

### License
MIT License
