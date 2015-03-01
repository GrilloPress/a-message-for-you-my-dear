# file that lets you create and read markdown files
# 

filename = ARGV.first

puts "we are going to erase #{filename}"
puts "If you don't want is to do that, press Ctrl+V"
puts "If you want to erase #{filename} press ENTER"

$stdin.gets

puts "opening #{filename}"
target = open(filename, 'w')
target.truncate(0)

puts "Let's write some shit now"

print "line one:"
line1 = $stdin.gets.chomp

target.write(line1)

target.close