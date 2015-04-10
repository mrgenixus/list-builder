# list-builder
Designed to capture names and email addresses for Marketing purposes

# Dependencies
- Postgres 9.3

# Setup

## gems
```
bundle install
```

## database
### configuration

```
cp config/database.example.yml config/database.yml
```

### schema
```
bundle exec rake db:setup
```

# Running the application
```
bundle exec rails s
```

