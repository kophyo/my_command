# MyCommand

My Command is a Ruby command line utility gem and has the following interface:
```ruby
$ my_command [browser|file|fact|save_facts]
```
##### 1. browser command
With 'browser' argument, my_command will open a new default browser window displaying an image of a cat.
It uses this api http://thecatapi.com/docs.html#get with image options only with xml format

##### 2. file command
With 'file' argument, my_command will save on the desktop an image of a cat, as an image file (with 'cat_image.jpg'). It uses this api http://thecatapi.com/docs.html#get with image options only with src format to save the file.

##### 3. fact command
With 'fact' argument, my_command will print to stdout a random cat fact. It uses this api http://catfacts-api.appspot.com/api/facts

##### 4. save_facts command
With 'save_facts' argument, my_command will saves 100 cat facts into txt file on Desktop (with 'cat_facts.txt'). It uses this api http://catfacts-api.appspot.com/api/facts?number=100

## Installation

To run this locally:

```ruby
rake install
```

## Usage

After running the 'rake install', you should be able to execute the my_command command with above arguments

## Limitation
With file and save_facts arguments, it only works for Mac OSX environments to save the files in Desktop directory.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kophyo/my_command.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

