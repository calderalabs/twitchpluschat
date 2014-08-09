# Twitch+Chat - Add Kappa to your VODs

Twitch+Chat provides you with a Rails application to store and retreive stored
Twitch IRC messages, a Thor task to run a bot listening and recording channel
messages and finally an Ember client to replay the chat together with a Twitch
VOD.

## Introduction

### How to start?

Clone the repository with git:

    $ git clone git://github.com/eugeniodepalo/twitchpluschat

Create your local database (this requires Postgres):

    $ rake db:create
    $ rake db:schema:load

Configure your development secrets/variables in `config/secrets.yml`.
You need at least to add your Twitch Client ID and your Twitch IRC credentials.

Start the logging bot:

    $ thor tpc:bot start

Start the web server:

    $ rails s

Visit the page for your favourite VOD:

    http://localhost:3000/:channel_id/b/:video_id

Where `:channel_id` is the name of the channel e.g. `sing_sing` and `:video_id`
is the id of the past broadcast e.g. `554034078`

## TODO

- Add some tests
- Add support for channel badges (subscriber, turbo, etc.)
- Add an index page to explain how it works

## Contributing

If you'd like to help improve Twitch+Chat, clone the project with Git by
running:

    $ git clone git://github.com/eugeniodepalo/twitchpluschat

Work your magic and then submit a pull request. We love pull requests!

If you find the documentation lacking, help us out and update this README.md. If
you don't have the time to work on Twitch+Chat, but found something we should
know about, please submit an issue.

## License

Twitch+Chat is released under the [MIT license](http://www.opensource.org/licenses/MIT).

## Authors

* [Eugenio Depalo](https://github.com/eugeniodepalo)
