require "rspec_screenshot_dashboard/version"

module RSpecScreenshotDashboard
  class Config
    class << self
      attr_accessor :output_dir
      attr_accessor :enabled
    end
    self.enabled = true
    self.output_dir = 'public/screenshot_overview'
  end

  autoload :Screenshot, 'rspec_screenshot_dashboard/screenshot'
  autoload :Manager, 'rspec_screenshot_dashboard/manager'
  autoload :CapybaraPatch, 'rspec_screenshot_dashboard/capybara_patch'
end

if defined?(RSpec)
  require 'rspec_screenshot_dashboard/adapters/rspec'
  require 'capybara'
  require 'capybara/dsl'
  Capybara::DSL.send(:prepend, RSpecScreenshotDashboard::CapybaraPatch)
end
