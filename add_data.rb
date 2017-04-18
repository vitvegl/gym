File.unlink('./add.sql') if File.exist?('./add.sql')
File.unlink('./data/add.sql') if File.exist?('./data/add.sql')

li = []

Dir.foreach('./data') do |script|
  li << script if script =~ /sql$/
end

li.sort!

li.each do |file|
  system("echo \"source #{file};\" >> add.sql")
end

system("cp -v ./add.sql data/")
