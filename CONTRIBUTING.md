# Contributing to the Children's Council

Hi there! We're glad you're interested in contributing to the Children's Council project. Before you do, please be sure to read the following:

## Where to get help or report an issue

### Bugs

* If your think you may have found a bug in a particular plugin, please open an issue against that project's repository directly.

### Questions

If you have a general question about Children's Council (e.g., a configuration question, a question specific to your site, upgrading, etc.) [contact Children's Council Support](mailto:support@childrenscouncil.org)

### Feature requests

General Children's Council feature requests, including requests to add additional plugins should be made via [Children's Council Support](mailto:support@childrenscouncil.org).

## Contributing

Interested in contributing? Great. We'd love you to. Before contributing be sure to read and understand [the project goals](https://github.com/github/pages-gem/blob/master/README.md#project-goals).

## How to contribute

1. Fork the project
2. Create a new, descriptively named branch
3. Commit your proposed changes
4. Submit a pull request

## Testing with Bundler

To test your Gem with [Bundler](http://bundler.io), you can:

1. Create a directory
2. Add a `Gemfile` like the following:

    ```ruby
    gem 'github-pages', :git => 'https://github.com/<you>/pages-gem.git', :branch => '<your branch name>', :require => 'gh-pages'
    ```

3. Execute `bundle install`
4. Test