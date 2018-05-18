module RSpecScreenshotDashboard
  module CapybaraPatch
    # @override
    def visit(url)
      _rspec_screenshot_dashboard_make_screenshot(url) do
        super
      end
    end

    # @override
    def click_button(*args)
      _rspec_screenshot_dashboard_make_screenshot(args.first) do
        super
      end
    end

    # @override
    def click_link(*args)
      _rspec_screenshot_dashboard_make_screenshot(args.first) do
        super
      end
    end

    # @override
    def click_on(*args)
      _rspec_screenshot_dashboard_make_screenshot(args.first) do
        super
      end
    end

    private

    def _rspec_screenshot_dashboard_make_screenshot(argument, &block)
      ex = if defined?(RSpec.current_example)
             RSpec.current_example
           else
             example
           end
      Manager.instance.rspec_click_hook(page, argument, ex) do
        yield
      end
    end
  end
end
