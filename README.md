# UberEmailer
[Coding exercise](https://github.com/uber/coding-challenge-tools) from Uber.

### What is it?
A simple emailer with failover via Mailgun then Mandrill. It allows
you to send an email from an address of your choosing, to a recipient of your
choosing.  

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

### License
MIT License
