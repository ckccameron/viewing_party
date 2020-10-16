# Viewing Party

This is our repo for the [viewing party paired project](https://backend.turing.io/module3/projects/viewing_party) during Turing's Backend Module 3. Example wireframes to follow can be found [here](https://backend.turing.io/module3/projects/viewing_party/wireframes).

## CI & Deployment

Builds are run by Travis CI: [![Build Status](https://travis-ci.org/ckccameron/viewing_party.svg?branch=main)](https://travis-ci.org/ckccameron/viewing_party)

The deployment for our application in production is handled by Heroku. Our application can be found here: [https://viewing-party-ac.herokuapp.com](https://viewing-party-ac.herokuapp.com).

## Contributors 
[Angela Guardia](https://github.com/AngelaGuardia) & 
[Cam Chery](https://github.com/ckccameron)

## Table of Contents
1. [About This Project](#about_this_project)
2. [Learning Achievements](#learning_achievements)
3. [Local Setup](#setup)
4. [Schema Design](#schema)
5. [Resources](#resources)

## About This Project <a name="about_this_project"></a>

Viewing party is an application in which users can explore movie options and create a viewing party event for the user and friends. A user registers with their name, email and password, and subsequently logs in to the application. Returning users can also login. Once they are authenticated, a user can discover movies by top 40 rated movies, or they can enter in a search query to look up results. Consuming TheMovieDB API allows us to call our movie data.

Viewing parties are created by the user, however the user must have added friends. Users can view all of the parties that they are either hosting or been invited to, and their dashboard page also allows them to add more friends at any time. 

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
