module RSpecScreenshotDashboard
  module CapybaraNodePatch
    # @override
    def click
      _rspec_screenshot_dashboard_make_screenshot do
        super
      end
    end

    def double_click
      _rspec_screenshot_dashboard_make_screenshot do
        super
      end
    end

    private

    def _rspec_screenshot_dashboard_make_screenshot(&block)
      ex = if defined?(RSpec.current_example)
             RSpec.current_example
           else
             example
           end
      Manager.instance.rspec_click_hook(@session, nil, ex) do
        yield
      end
    end
  end
end
