:""||"-*-ruby-*-";exec "${RUBY-ruby}" "-x" "$0" "$@"||exit||<<'#'if nil
@if "%RUBY%" == "" (ruby -x "%~f0" %*) else ("%RUBY%" -x "%~f0" %*)
@exit /b %ERRORLEVEL%
#
#!ruby -w
require 'fileutils'
include FileUtils::Verbose

mkdir_p "rakelib"
%w[changelogs epoch].each do |rb|
  rakelib = "rakelib/#{rb}.rake"
  unless File.exist?(rakelib)
    puts "Writing #{rakelib}"
    File.write(rakelib, "require 'ruby-core/#{rb}'\n")
  end
end

if File.directory?("ext")
  File.open("Rakefile", "r+") do |rf|
    unless (r = rf.read).include?("ruby-core/extensiontask")
      r.sub!(/(?:^(?:#|$|require).*\n)*\K/, "#{<<~"begin;"}\n#{<<~'end;'}")
      begin;
        require 'ruby-core/extensiontask'
        extask = RubyCore::ExtensionTask.new(Bundler::GemHelper.instance)
      end;
      rf.rewind
      rf.truncate(0)
      rf.write(r)
    end
  end
end
