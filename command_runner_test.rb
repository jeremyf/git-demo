#!/usr/bin/env ruby

require 'test/unit'
require File.join(File.dirname(File.expand_path(__FILE__)), 'command_runner.rb')

class CommandRunnerTest < Test::Unit::TestCase
  def test_command_runner_responds_to_do
    assert_respond_to CommandRunner.new, :do
  end

  def test_command_runner_file_exists
    tested_file = File.read(File.join(File.dirname(__FILE__), 'file.txt'))
    assert_equal CommandRunner::VALUE, tested_file.strip
  end
end