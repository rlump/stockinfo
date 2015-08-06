# stockinfo rails server

* provide symbol lookup by company name
* provides thirty stock price history

### Setup (rails required, default database sqlLite)
 1. $> rake db:migrate
 2. $> rake db:seed

### Then run it (eg. rails -s )

### Routes supported with json output
  1. /stocks?[name=aaa..] - gets all listed companies by name and symbol
     or a subset of those with names beginning with the case insensitive optional
     name argument
  2. /prices?symbol=XXX - gets thirty price history array containing high, low, open,
     and close
