# README
## Get the app running on your dev machine

`git clone https://www.github.com/....?whatrepo?`

`cd browserstack_test`

`bundle install`

`rake db:migrate && rake db:test:prepare`

## Check that it's running

`rails server`

then you should be able to point your browser to localhost:3000/users

## Run the tests locally

`rspec spec/features`

## Run on BrowserStack

```
export browserstack_user=<your browserstack username>
```
```
export browserstack_key=<your browserstack key>
```

to run on IE11/Windows
```
BROWSER=ie rspec spec
```

to run on Chrome/Windows
```
BROWSER=chrome rspec spec
```
