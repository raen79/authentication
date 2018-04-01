# Authentication
> Api for an authentication service that allows for the registration/authentication of users and their retrieval.

[![Build Status](https://travis-ci.org/raen79/authentication.svg?branch=master)](https://travis-ci.org/raen79/authentication)
[![Maintainability](https://api.codeclimate.com/v1/badges/027f7a8ce9ba3713711c/maintainability)](https://codeclimate.com/github/raen79/authentication/maintainability)
## Getting Started
### Prerequisites
- Ruby 2.3
- Rails 5.1
- Postgres
- An RSA key pair
### Installation
#### Environment Variables
`dot-env` gem is installed and so you can set up all your environment variables in a .env file at the root of the project. The following environment variables need to be set:
```
DB_USER = username for you DB
DB_PWD = password for your DB user
RSA_PUBLIC_KEY = Your public RSA key (don't worry about \n, they are handled)
RSA_PRIVATE_KEY = Your RSA private key (don't worry about \n, they are handled)
```
The production environment only needs `RSA_PRIVATE_KEY` and `RSA_PUBLIC_KEY` set up.
#### Database
```
$ bundle exec rails db:setup
```
## Documentation
http://auth-mservice.herokuapp.com/api_docs/swagger#/Authentication
## Running the Tests
`bundle exec rspec`
## Author
- Name: Eran Peer
- Email: eran.peer79@gmail.com
