
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rspec_screenshot_dashboard/version"

Gem::Specification.new do |spec|
  spec.name          = "rspec_screenshot_dashboard"
  spec.version       = RspecScreenshotDashboard::VERSION
  spec.authors       = ["Stefan Wienert"]
  spec.email         = ["info@stefanwienert.de"]

  spec.summary       = 'Hooks into Capybara/Selenium and takes screenshots before/after each click in all tests and generates an dashboard/overview to compare/check for design probs'
  spec.description   = "Hooks into RSpec and makes browser screenshots in all js-feature specs. It works, by hooking into Capybara's click_on, click_button, etc. methods and will make a screenshot before and after each click. After all tests run, it will generate a report page, default under public/screenshot_overview (which can conveniently be viewed through the dev server: http://localhost:3000/screenshot_overview/)."
  spec.homepage      = "https://github.com/zealot128/ruby-rspec_screenshot_dashboard"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files = `git ls-files -z`.split("\x0").select { |f|
    !f.match(%r{^(bin|test|spec|features)/}) && (!f[/^dashboard/] || f[%r{dashboard/dist}])
  }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
