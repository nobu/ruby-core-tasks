# Ruby Core Tasks

Welcome to the completely useless gem for other than ruby committers.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ruby-core-tasks

If bundler is not being used to manage dependencies, install the gem
by executing:

    $ gem install ruby-core-tasks

## Usage

Add to Rakefile:

    require "bundler/gem_tasks"
    require "rake/testtask"
    require "ruby-core/extensiontask"

    helper = Bundler::GemHelper.instance
    extask = RubyCore::ExtensionTask.new(helper.gemspec)
    Rake::TestTask.new(:test) do |t|
      t.libs.unshift(*extask.libs)
      # ...
    end

Then:

    $ rake test

And:

    $ ruby -I.build/run -r myext/foo -e '# the built myext/foo is loaded'

## Development

May the source be with you.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/nobu/ruby-core-tasks.
