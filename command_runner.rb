# Rubygems is a package management tool for Ruby.
require 'rubygems'

# HighLine eases the possibly tedious handling of console input and output.
# Source: http://github.com/JEG2/highline
require 'highline'

# I'm going to be running lots of commands, and explaining what is going on,
# so I created a simple class to handle this.
# I could instead create a function.
class CommandRunner

  def self.context(&block)
    CommandRunner.new.tap { |cr|
      cr.instance_eval(&block)
    }
  end

  VALUE = "2"

  def run(command, message)
    info(message,"\nRunning:\n", "  $ #{command}")
    Kernel.system("cd #{target_directory} && #{command}")
    ask("\n[Press Enter to continue]\n \n")
  end

  def info(*args)
    message = messagify(true, *args)
    highline.say(highline.color(message, :white, :on_blue))
  end

  def ask(*args, &block)
    message = messagify(false, *args)
    highline.ask(highline.color(message, :white, :on_green), &block)
  end

  def target_directory
    return @target_directory if @target_directory

    response = File.join(ENV['HOME'],'/Desktop/demo') # highline.ask('Where do you want the demo?')

    # Creating an instance variable which is accessible within the scope
    # of this newly object.
    @target_directory = Pathname.new(response)

    @target_directory.rmtree if @target_directory.exist?
    if @target_directory.exist?
      raise "Target Directory Already Exists"
    else
      @target_directory.mkpath
    end
    @target_directory
  end

  protected
  def messagify(padding = false, *args )
    length = 80

    lines = args.flatten.join("\n").gsub(/(.{1,#{length}})( +|$)\n?|(.{#{length}})/,
        "\\1\\3\n").split(/\n/)

    empty_line = "\n" << " " * (6 + length)
    lines.inject("#{empty_line if padding}") {|m,v|
      m << "\n"  << " " * 3 << v << " " * (3 + length - v.length )
    }.tap {|response|
      response << empty_line << "\n"  << "   (see below)" <<  " " * 72 << empty_line if padding
    }
  end

  def highline
    @highline ||= HighLine.new
  end
end