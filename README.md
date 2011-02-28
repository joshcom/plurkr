Plurkr
======
A Ruby library for the Plurk HTTP API: http://www.plurk.com/API

Installation
------------
TODO

Documentation
-------------
TODO

Usage
-----
    require "rubygems"
    require "plurkr"

    Plurkr.configure do |p|
      p.api_key = "MYKEY"
      p.password = "PLURK_PASSWORD" 
      p.username = "PLURK_USERNAME"
    end
      
    # Retrieve your profile information
    my_profile = Plurkr.profile.my

    # Retrieve your public profile
    my_public_profile = Plurkr.profile.for my_profile.user_info.uid
