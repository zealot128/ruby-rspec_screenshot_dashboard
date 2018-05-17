module RSpecScreenshotDashboard
  module CapybaraPatch
    # @override
    def visit(url)
      super
      _rspec_screenshot_dashboard_make_screenshot(url)
    end

    # @override
    def click_button(*args)
      super
      _rspec_screenshot_dashboard_make_screenshot(args.first)
    end

    # @override
    def click_link(*args)
      super
      _rspec_screenshot_dashboard_make_screenshot(args.first)
    end

    # @override
    def click_on(*args)
      super
      _rspec_screenshot_dashboard_make_screenshot(args.first)
    end

    private

    def _rspec_screenshot_dashboard_make_screenshot(argument)
      ex = if defined?(RSpec.current_example)
             RSpec.current_example
           else
             example
           end
      if ex && (ex.metadata[:js] || ex.metadata[:screenshot]) && RSpecScreenshotDashboard::Config.enabled
        filename = Manager.instance.add_image_from_rspec(argument, ex, current_path)
        page.save_screenshot(Rails.root.join(filename).to_s, full: true)
      end
    end
  end
end
