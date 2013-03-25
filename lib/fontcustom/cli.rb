require "thor"
require "fontcustom"

module Fontcustom
  class CLI < Thor
    # TODO update (templates:array, etc)
    class_option :output, :aliases => "-o", :desc => "Specify an output directory. Default: $DIR/fontcustom"
    class_option :name, :aliases => "-n", :desc => "Specify a font name. This will be used in the generated fonts and CSS. Default: fontcustom"
    class_option :font_path, :aliases => "-f", :desc => "Specify a path for fonts in css @font-face declaration. Default: none"
    class_option :nohash, :type => :boolean, :default => false, :desc => "Disable filename hashes. Default: false"
    class_option :debug, :type => :boolean, :default => false, :desc => "Display debug messages. Default: false"
    class_option :html, :type => :boolean, :default => false, :desc => "Generate html page with icons"

    desc "compile DIR [options]", "Generates webfonts and CSS from *.svg and *.eps files in DIR."
    def compile(input_dir)
      options.merge! {:input_dir => input_dir}
      Fontcustom::Base.new(options).generate_all
    end

    desc "watch DIR [options]", "Watches DIR for changes and regenerates webfonts and CSS automatically. Ctrl + C to stop."
    def watch(input_dir)
      options.merge! {:input_dir => input_dir, :watching => true}
      options = Fontcustom::Options.new(options)
      Fontcustom::Watcher.new(options).watch
    end
  end
end