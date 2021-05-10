# Mastermind

An implementation of the game *Mastermind*, developed as part of the The Odin Project Ruby Track exercises.


The game offers two play modes:
1. **Player vs Computer** - the player is the code breaker and the computer as code maker.
   
2. **Computer vs Player** - the computer is the code breaker and the player the maker.  The computer uses a Knuth minmax (worst-case) algorithm to determine it's next guess.  This algorithm was utilized for programming learning goals, not for game fun-factor.  *Typically, the computer will crack the code within 7 moves, thus making it virtually impossible for the player to beat it as the code maker.*  

Additional information on Mastermind:
https://en.wikipedia.org/wiki/Mastermind_(board_game)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mastermind'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mastermind

## Usage

Execute:

    $ ruby example/example.rb

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Hokie007/mastermind.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
