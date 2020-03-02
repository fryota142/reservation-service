# Reservation Service
## install
### Clone the repository
```
  $ git clone git@github.com:fryota142/reservation-service.git
```
### Ruby version
`
ruby '2.6.3'
`
### System dependencies
```
$ bundle install
```
### Database(Mysql)
```
$ brew install mysql
$ mysql.server start
```

### Database initialization
```
$ rails db:create db:migrate
```

### Server
```
$ rails s
```
