module RSpecScreenshotDashboard
  class Screenshot
    ATTR = [:url, :argument, :full_path, :group_description, :example_description, :file_with_line].freeze
    attr_accessor(*ATTR)
    def initialize(opts = {})
      opts.each do |k, v|
        send("#{k}=", v)
      end
    end

    def as_json(opts = {})
      ATTR.map { |k| [k, send(k)] }.to_h.merge(
        local_image: local_image,
        full_image_path: full_image_path,
        line_number: line_number,
        full_test_path: full_test_path,
        snippet: snippet,
        test_file: test_file
      )
    end

    def local_image
      @_local_image ||=
        begin
          prefix = (
            file_with_line.remove(Rails.root.to_s).remove('/spec').split(%r{[/:]})[1..-2].map { |i| i.remove('_spec.rb') } +
            [*group_description, example_description].compact
          ).map { |i| i.gsub(/\W+/, '_') }
          digest = Digest::MD5.hexdigest([file_with_line, snippet].join)
          File.join(*prefix, digest + '.png')
        end
    end

    def full_image_path
      File.join(Config.output_dir, 'screenshots', local_image)
    end

    def line_number
      file_with_line.split(":")[1].to_i
    rescue
      0
    end

    def full_test_path
      file_with_line.split(":")[0]
    end

    def snippet
      File.read(full_test_path).lines[line_number - 5, 9].tap { |i| i[4] = ">>" + i[4].gsub(/^  /, '') }.join
    end

    def test_file
      file_with_line.gsub(Dir.pwd, '').gsub(/:\d+$/, '')
    end
  end
end
