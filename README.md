# DNS Challenge

A small API made for a challenge

## About

This application has two endpoints, one for receiving a DNS ip with its domains, and other to retrieve the DNS servers information based on domains.

* POST /v1/dns_servers;
* GET  /v1/search

## System dependencies

* [Postgres](https://www.postgresql.org/docs/10/tutorial-install.html) - 10
* [Ruby](https://www.ruby-lang.org/en/documentation/installation/) - 2.6.2

## Development

## Setup for development

Take a look at the `.env.development` and `.env.test` file and make sure `DATABASE_URL` environment variable is correct for your environment (use your Postgres configuration).

Install all gems and create the development database for the first time:

```bash
$ bundle install
$ bin/rails db:setup
```

## Running the server

To run the server locally, run the command:

```
$ rails server
```

You can stop the server by pressing:

```
CTRL + C
```

## Running the tests

Just run the command:

```
$ bundle exec rspec
```

Or just:

```
$ rspec
```

It will generate the file `coverage/index.html` containing the test results.

## Committing

Before allowing you to commit your code, [Overcommit](https://github.com/sds/overcommit) will run hooks, such as RuboCop and TrailingWhitespace, to the check your code.

Install Overcommit hooks:

```
$ overcommit --sign
$ overcommit --install
```

Now you can commit.

## License

This project is released under the [MIT License](https://opensource.org/licenses/MIT).

## Credits

Made by Emanuel Merayo Goldenberg