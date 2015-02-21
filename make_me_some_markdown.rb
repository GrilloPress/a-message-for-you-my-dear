# This file contains a method which when called will prompt the user through the command line to end the name of a markdown file.
# The second one with gsub method kills all whitespace and makes just one word

def make_me_some_markdown
	puts "write the name of the markdown file"
	file = gets.chomp.downcase
	puts `touch #{file}.md`
end

def make_me_some_markdown_cleaner
	puts "write the name of the markdown file"
	file = gets.chomp.downcase.gsub(/\s+/, "")
	puts `touch #{file}.md`
end

def make_me_some_markdown_multi_ball

	puts "write the name of the markdown files you want creating"
	a = gets.chomp.downcase
	array = a.split(' ')
	p array
	
	array.each do |f|
		puts `touch #{f}.md`
	end

end

make_me_some_markdown_multi_ball

