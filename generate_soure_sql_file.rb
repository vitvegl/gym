#!/usr/bin/env ruby
require 'erb'
require 'date'
require 'optparse'

opts = OptionParser.new do |opt|
  opt.on("--athlet=name", String) do |athlet|
    @athlet = athlet
  end

  opt.on("--workout-date=year:month:day, without ':'", String) do |workout_date|
    dt = DateTime.parse(workout_date)
    @date = dt.strftime("%Y%m%d")
  end

  opt.on("--workout-duration=hours:minutes", String) do |workout_duration|
    dt = DateTime.parse(workout_duration)
    @duration = dt.strftime("%H:%M")
  end

  opt.on("--start-time=[year:month:day hours:minutes]", String) do |start_time|
    st = DateTime.parse(start_time)
    @start_time = st.strftime("%Y-%m-%d %H:%M")
  end

  opt.on("--finish-time=[year:month:day hours:minutes]", String) do |finish_time|
    ft = DateTime.parse(finish_time)
    @finish_time = ft.strftime("%Y-%m-%d %H:%M")
  end

  opt.on("--workout-type=(split|fullbody)", String) do |workout_type|
    if workout_type === "split" or workout_type === "fullbody"
      @workout_type = workout_type
    else
      raise TypeError
    end
  end

  opt.on("--number=workout_number", Integer) do |number|
    @number = number
  end

  opt.on("--workout-style=(пояc|лямки|бинти|одяг|без екіпірування)") do |style|
    case style
    when "пояс", "лямки", "бинти", "одяг", "без екіпірування"
      @style = style
    else
      raise TypeError
    end
  end

  opt.on("--workout-equipment=(штанга|гантель|гантелі|гиря|гирі|снаряд|тренажер|власна вага)") do |equipment|
    case equipment
    when "штанга", "гантель", "гантелі", "гиря", "гирі", "снаряд", "тренажер", "власна вага"
      @equipment = equipment
    else
      raise TypeError
    end
  end
end

def insert_data_into_sql_file

  if self.instance_variable_defined?(:@start_time) and self.instance_variable_defined?(:@finish_time)
    template = "template.sql.erb"
  else
    template = "duration_template.sql.erb"
  end

  sql_file = "#{@number}-#{@athlet}#{@date}.sql"

  begin
    if File.exist?(template)
      data = ERB.new(IO.read(template))
      f = File.open(sql_file, "wb")
      f.write(data.result)
    else
      raise "Template #{template} not found"
    end
  rescue IOError => e
    puts e.message
  ensure
    f.close
  end

end

def run
  raise OptionParser::MissingArgument unless self.instance_variable_defined?("@athlet")
  raise OptionParser::MissingArgument unless self.instance_variable_defined?("@date")
  #raise OptionParser::MissingArgument unless self.instance_variable_defined?("@duration")
  raise OptionParser::MissingArgument unless self.instance_variable_defined?("@workout_type")
  raise OptionParser::MissingArgument unless self.instance_variable_defined?("@number")
  raise OptionParser::MissingArgument unless self.instance_variable_defined?("@style")
  raise OptionParser::MissingArgument unless self.instance_variable_defined?("@equipment")

  if not self.instance_variable_defined?("@duration") and not self.instance_variable_defined?("@start_time") and not self.instance_variable_defined?("@finish_time")
    raise OptionParser::MissingArgument
  end

  insert_data_into_sql_file
end

begin
  opts.parse!
  run
rescue TypeError, OptionParser::InvalidArgument, OptionParser::MissingArgument
  print opts.help
  exit 1
end
