# frozen_string_literal: true

require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "debug"
end

require "fileutils"
require "pathname"

if ARGV[0].nil? || ARGV[0] == "-h"
  puts "script/build.rb <git ref>"
  puts "eg. script/build.rb v1.8.2"
  puts "eg. script/build.rb master"
  exit 1
end

ref = ARGV[0]

vendor_dir = File.expand_path(File.join(__dir__, "..", "vendor"))
FileUtils.mkdir_p(vendor_dir)

FileUtils.rm_r("src")
FileUtils.mkdir("src")

Dir.chdir(vendor_dir) do
  if File.directory?("opal")
    FileUtils.rm_r("opal")
  end

  system("git clone --depth 1 --branch #{ref} https://github.com/opal/opal.git")

  Dir.chdir("opal") do
    system("bundle install")
    system("yarn install")
    system("bundle exec rake dist")

    Dir.chdir("build") do
      Dir.glob("*.js") do |src_path|
        next if src_path.end_with?(".min.js")

        FileUtils.cp(src_path, File.join("..", "..", "..", "src", src_path))
      end
    end
  end
end

#### opal.js ####
opal_js_path = File.join("src", "opal.js")
opal_js_lines = File.read(opal_js_path).split("\n")
index = opal_js_lines.index { |line| line.strip == 'Opal.loaded(["corelib/runtime.js"]);' }
opal_js_lines.insert(index, "const Opal = this.Opal;")

opal_js = <<~JAVASCRIPT
  const globalThis = {};

  function bootstrap() {
    #{opal_js_lines.join("\n")}
  }

  bootstrap.apply(globalThis);

  export default globalThis.Opal;
JAVASCRIPT

File.write(opal_js_path, opal_js)

#### other modules

Dir.glob("src/*.js") do |src_path|
  contents = File.read(src_path)
  contents = <<~JAVASCRIPT
    import Opal from "./opal.js"
    #{contents}
  JAVASCRIPT

  File.write(src_path, contents)
end
