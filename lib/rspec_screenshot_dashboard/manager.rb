module RSpecScreenshotDashboard
  class Manager
    include Singleton
    def start
      @started = true
      @screenshots = []
      @sequence_number = 0
      FileUtils.mkdir_p File.join(Config.output_dir, 'screenshots')
    end

    def started?
      @started
    end

    def rspec_click_hook(page, argument, rspec_example, &block)
      return unless RSpecScreenshotDashboard::Config.enabled

      if rspec_example && (rspec_example.metadata[:js] || rspec_example.metadata[:screenshot])
        filename = add_image_from_rspec(argument, rspec_example, page.current_path)
        page.save_screenshot(Rails.root.join(filename).to_s, full: true)
        yield
        page.save_screenshot(Rails.root.join(filename.to_s.sub('.png', '_after.png')).to_s, full: true)
      end
    end

    def add_image_from_rspec(argument, example, url_path)
      blob = caller.find { |i| i[example.file_path.gsub(/:\d*|^\./, "")] }
      file_with_line = blob.split(":")[0, 2].join(":")

      describe = example.metadata[:example_group][:description_args]
      screenshot = Screenshot.new(url: url_path,
                                  argument: argument,
                                  backtrace: caller.take(10),
                                  sequence_number: @sequence_number += 1,
                                  group_description: describe,
                                  example_description: example.description,
                                  file_with_line: file_with_line)
      @screenshots << screenshot
      screenshot.full_image_path
    end

    def stop
      File.write File.join(Config.output_dir, 'index.json'), @screenshots.to_json
      dist_files = Dir[File.join(File.dirname(__FILE__), '../../dashboard/dist/*')]
      FileUtils.cp_r(dist_files, Config.output_dir)

      warn "[RspecScreenshotDashboard] Overview generated with #{@screenshots.count} Screenshots to #{Config.output_dir}"
      @started = false
    end
  end
end
