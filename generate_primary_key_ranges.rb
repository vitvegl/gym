#!/usr/bin/env ruby
require 'optparse'

def print_list_as_string(range)
  raise TypeError unless range.class == Range

  out = String.new

  range.each do |element|
    out << "("
    out << "#{element}"
    out << ")"

    unless element == range.last
      out << ","
      out << " "
    end
  end

  puts out
end

opts = OptionParser.new do |opt|
  opt.on("--first=number", Integer) do |first|
    @first = first
  end
  opt.on("--last=number", Integer) do |last|
    @last = last
  end
end

def run
  arg = Range.new @first, @last
  print_list_as_string(arg)
end

begin
  opts.parse!
  run
rescue TypeError, OptionParser::InvalidArgument, OptionParser::MissingArgument
  print opts.help
  exit 1
end
