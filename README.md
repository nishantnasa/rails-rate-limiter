# Rails Rate-Limiter

## Overview
Limits the number of application requests to 100 per hour

## Installation

If not specified, you must run all commands below on `rate-limiter` root directory.

### rvm

Install rvm unless you already have it installed.

```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --rails
```

### ruby

Install ruby unless you already have it installed.

```
ruby -v
rvm install ruby 2.2.0
rvm list
rvm gemset create rails4.2
rvm gemset list
rvm use ruby-2.2.0@rails4.2
gem install rails --version=4.2.5
rails -v
which ruby
which rails
``` 

#### gems

Install ruby gems.

```
gem install bundler
bundle install
```

### database migration

Create and migrate database. See below.

## Database

### create DB

```
rake db:create
```

### migrate

```
rake db:migrate
```

### drop DB

```
rake db:drop
```

## Run

Run server locally.

```
rails s
```

## Test

Run tests.

```
RAILS_ENV=test rake db:drop db:create db:migrate
bin/rspec
```

## Syntax check

```
bin/rubocop
```

## Routes

Show routes.

```
rake routes
```
