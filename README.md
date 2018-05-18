# RspecScreenshotDashboard WIP

Hooks into RSpec and makes browser screenshots in all js-feature specs. It works, by hooking into Capybara's click_on, click_button, etc. methods and will make a screenshot before and after each click.
After all tests run, it will generate a report page, default under public/screenshot_overview (which can conveniently be viewed through the dev server: http://localhost:3000/screenshot_overview/).

Current state: WIP

## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'rspec_screenshot_dashboard'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec_screenshot_dashboard

## Usage

Requires usage of Capybara with a screenshotable browser (Selenium Chromedriver, Poltergeist)

When requiring the Gem, it will automatically hook into RSpec's before block.

Config can be set before starting tests (like spec_helper or support file)

```
RSpecScreenshotDashboard::Config.enabled = true
RSpecScreenshotDashboard::Config.output_dir = 'public/screenshot_overview'
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zealot128/ruby-rspec_screenshot_dashboard.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
