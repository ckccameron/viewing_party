# [Viewing Party](https://viewing-party-ac.herokuapp.com)

Viewing party is an application created by [Angela Guardia](https://github.com/AngelaGuardia) & 
[Cam Chery](https://github.com/ckccameron), as part of the Turing School of Software and Design Backend [curriculum](https://backend.turing.io/module3/projects/viewing_party). It was completed over a period of 10 days.

## Table of Contents
1. [CI & Deployment](#deployement)
1. [About This Project](#about_this_project)
2. [Learning Achievements](#learning_achievements)
3. [Local Setup](#setup)
4. [Schema Design](#schema)
1. [Testing](#testing)
1. [Contributors](#contributors)
5. [Resources](#resources)

## CI & Deployment <a name="deployement"></a>

Builds are run by Travis CI: 
[![Build Status](https://travis-ci.org/ckccameron/viewing_party.svg?branch=main)](https://travis-ci.org/ckccameron/viewing_party)

The deployment for our application in production is handled by Heroku and can be accessed here:

[Viewing Party](https://viewing-party-ac.herokuapp.com)

If you'd like to get the full experience you can use this account that already has friends and viewing parties added:

`email: visitor@email.com`

`password: 1234`


## About This Project <a name="about_this_project"></a>

Viewing party web application that allows the user to explore movies and create events to watch them with friends. Users can register with their name, email, and password, and are automatically logged into the application. Returning users can also login. Once they are authenticated, users can discover movies by top 40 rated movies, or they can search vy movie title and get the top matching results. Movie pages show movie information as well as a poster and trailer. All movie data is obtianed by [TheMovieDB API](https://developers.themoviedb.org/3/getting-started/introduction).

Users can add friends through their email addresses. Users can then create viewing parties by picking a movie, a date, and adding friends. On the user dashboard users can view all of the parties that they are either hosting or been invited to. 

## Learning Achievements <a name="learning_achievements"></a>

- Consume JSON APIs that require authentication
- Implement basic authentication 
- Implement a self-referential relationship in ActiveRecord 
- Apply RuboCop’s style guide for code quality 
- Utilize Continuous Integration using Travis CI and deploy to production using Heroku

## Local Setup <a name="setup"></a>

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{create,migrate}`
4. Install Figaro gem to gain access to your local application.yml file: `bundle exec figaro install`
5. Add your API key to application.yml file: must be in format of `TMDB_API_KEY: "<your API key>"`

  ### Versions

  - Ruby 2.5.3
  - Rails 5.2.4.3
  
## Schema Design <a name="schema"></a>

<img width="877" alt="Screen Shot 2020-10-15 at 8 08 56 AM" src="https://user-images.githubusercontent.com/57038617/96149478-3757ad00-0ebe-11eb-97f5-2b450efca0c9.png">

## Testing

We used RSpec with the help of Capybara, Shoulda-matchers, FactoryBot, Webmock, and VCR to implement thorough and efficient tests that resulted in full test coverage:

![Screen Shot 2020-10-14 at 7 50 07 PM](https://user-images.githubusercontent.com/47278429/96194683-c89b4380-0eff-11eb-9c37-792634af2509.png)

## Contributors <a name="contributors"></a>
[Angela Guardia](https://github.com/AngelaGuardia)

[Cam Chery](https://github.com/ckccameron)

## Resources <a name="resources"></a>
- [TheMovieDB API](https://developers.themoviedb.org/3/getting-started/introduction)
  - We used the following endpoints:
    - "/movie/top_rated"
    - "/search/movie"
    - "/movie/{movie_id}"
    - "/movie/{movie_id}/credits"
    - "/movie/{movie_id}/reviews"
    
- [Power of Self-Referential Relationships](https://medium.com/@ingridf/the-power-of-self-referential-associations-in-rails-and-self-joins-a9d31b181e4)

- [Ruby on Rails docs](https://apidock.com/rails)
