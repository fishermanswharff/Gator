[![Build status][ci-image]][ci-url] [![Code Climate](https://codeclimate.com/github/fishermanswharff/Gator/badges/gpa.svg)](https://codeclimate.com/github/fishermanswharff/Gator)

Gator
=========
[Visit Gator Here](http://gator.herokuapp.com)

Features
-----------
* Multi oAuth Providers: Twitter, LinkedIn, Instagram
* Add your own RSS feed!
* Select from preset feeds from popular RSS providers!
* Read your Twitter timeline, LinkedIn feeds, Instagram feed and your favorite news all in one place.
* See feeds other users added on the home page
* #nobootstrap
* #nofoundation
* #nofrontendframeworks

Project Description
---------
This project was completed to meet the requirements for Project 1 of General Assembly's Web Development Immersive. It was conceived, scoped and developed in a week. 

Installation
--------
This app requires multiple API keys: 

* Twitter
* LinkedIn, with permissions to read (and write) network updates (rw_nus)
* Instagram

Gator looks for environment variables with these names:

      TWITTER_CONSUMER_KEY
      TWITTER_CONSUMER_SECRET
      INSTAGRAM_CLIENT_ID
      INSTAGRAM_CLIENT_SECRET
      LINKEDIN_KEY
      LINKEDIN_SECRET_KEY

Works in progress: 

* Featured images for RSS feeds.
* Cross-browser compatibility for CSS3 transitions
* Rescuing Twitter Too Many Requests Errors


Wireframes and schema preparation:
----------------
![wireframes and schema](/docs/whiteboard-notes.jpg "Whiteboard notes")


[ci-image]: https://travis-ci.org/fishermanswharff/Gator.svg?branch=master
[ci-url]: https://travis-ci.org/fishermanswharff/Gator