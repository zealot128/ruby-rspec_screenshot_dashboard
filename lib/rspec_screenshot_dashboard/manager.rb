module RSpecScreenshotDashboard
  class Manager
    include Singleton
    def start
      @started = true
      @screenshots = []
      FileUtils.mkdir_p File.join(Config.output_dir, 'screenshots')
    end

    def started?
      @started
    end

    def add_image_from_rspec(argument, example, url_path)
      blob = caller.find { |i| i[example.file_path.gsub(/:\d*|^\./, "")] }
      file_with_line = blob.split(":")[0, 2].join(":")

      describe = example.metadata[:example_group][:description_args]
      screenshot = Screenshot.new(url: url_path,
                                  argument: argument,
                                  group_description: describe,
                                  example_description: example.description,
                                  file_with_line: file_with_line)
      @screenshots << screenshot
      screenshot.full_image_path
    end

    def stop
      File.write File.join(Config.output_dir, 'index.json'), @screenshots.to_json
      @started = false
    end
  end
end
