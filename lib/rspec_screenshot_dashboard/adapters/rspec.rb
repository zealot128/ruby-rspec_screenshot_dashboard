RSpec.configure do |config|
  manager = RSpecScreenshotDashboard::Manager.instance
  config.before(:each, js: true) do
    if !manager.started? && RSpecScreenshotDashboard::Config.enabled
      manager.start
    end
  end
  config.after(:suite) do
    if manager.started?
      manager.stop
    end
  end
end
