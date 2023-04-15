# README

Software Requirements
---------------------

* Install Rails 7

* Install Ruby version 3.X

* Instal Postgresql 

* Instal Redis

Add below gem
=============

Token Based Authentication
--------------------------

gem 'jwt'

Password Encryption
-------------------

gem 'bcrypt', '~> 3.1.7'

Websocket connection
--------------------
gem 'faye-websocket'
gem 'eventmachine'

* We are adding eventmachine for dependecy gem for websocket

Serialize Json object
---------------------

gem 'fast_jsonapi'

Background workder
------------------

gem 'sidekiq'
gem 'redis'

* We need to add dependecy for queing process redis gem

Execute an Application
==================

Clone a repository
------------------

git clone git@github.com:mohanrajkpm/Price_app.git

Enter into an application
-------------------------

cd price_app

bundle install

rails s

Run Redis
---------

Open new tab with project folder in terminal

redis-server

Run Sidekiq
-----------
Open new tab with project folder in terminal

bundle exec sidekiq

Run WebSocket
-------------
Open new tab with project folder in terminal

rails runner app/services/binance_price_services.rb



API Documentation
=================

a. Discovering Pricing alert API
----------------------------------

    We can create a user then along with user we can create alert 

Create User
------------

Request URL
-----------

http://localhost:3000/users


Method
------

POST

Headers
-------

Accept: application/json
Content-Type: application/json

Body Parameters
------------------

{
    "username": "xxxx",
    "email": "testmail@gmail.com",
    "password": "12345678",
    "password_confirmation": "12345678"
}

Response
--------

{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "username": "xxxx",
            "email": "testmail@gmail.com"
        }
    }
}


Login User
----------

    We can login user with the credentials

Request URL
-----------

http://localhost:3000/auth/login


Method
------

POST

Headers
-------

Accept: application/json
Content-Type: application/json


Request Parameters
------------------

email: testmail@gmail.com
password: 12345678

Response
--------

{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE2ODE2MjU2NjR9.30hVGsIDWx3U7HW5IXZV_gIvi9KXNe6_z-zHeyqiGlM",
    "exp": "04-16-2023 11:44",
    "email": "testmail@gmail.com"
}

Create an Alert
---------------

    We can create an alert based on user

Request URL
-----------

http://localhost:3000/alerts


Method
------

POST

Authentication
--------------

Bearer token xxtttkjdkfjk

Headers
-------

Accept: application/json
Content-Type: application/json


Body Parameters
---------------

{
    "price": "-511.21"

}


Response
--------

{
    "data": {
        "id": "23",
        "type": "alert",
        "attributes": {
            "price": "-511.21",
            "status": "created",
            "user_id": 1
        }
    }
}



Fetch All Alerts
----------------

Request URL
-----------

http://localhost:3000/alerts?page%5Bsize%5D=1


Method
------

GET

Authentication
--------------

Bearer token xxtttkjdkfjk

Request parameters
------------------

page%5Bsize%5D: 1

filter%5Bstatus%5D: created/triggered

Response
--------

Filter-status: triggered

{
    "data": [
        {
            "id": "1",
            "type": "alert",
            "attributes": {
                "price": "-511.21",
                "status": "triggered",
                "user_id": 2
            }
        }
    ],
    "meta": {
        "total": 1,
        "pages": 1
    },
    "links": {
        "self": "http://localhost:3000/alerts?filter[status]=triggered&page[size]=3"
    }
}


Filter-status: created

{
    "data": [
        {
            "id": "2",
            "type": "alert",
            "attributes": {
                "price": "-515.21",
                "status": "created",
                "user_id": 2
            }
        },
        {
            "id": "3",
            "type": "alert",
            "attributes": {
                "price": "-545.21",
                "status": "created",
                "user_id": 2
            }
        },
        {
            "id": "4",
            "type": "alert",
            "attributes": {
                "price": "-645.21",
                "status": "created",
                "user_id": 2
            }
        }
    ],
    "meta": {
        "total": 3,
        "pages": 1
    },
    "links": {
        "self": "http://localhost:3000/alerts?filter[status]=created&page[size]=3"
    }
}

Incorrect Bearer Token
----------------------

Response
--------


{
    "errors": "Please try to login again!"
}

