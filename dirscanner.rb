
require 'net/http'

rr = []
t=[*0..9]

File.foreach('apps/DirBuster-0.12/directory-list-2.3-small.txt').with_index do |line, line_num|
	rr << line.sub(/\n/,'')
end

line_n 	 = rr.length
thread_n = 10
block_item=line_n / thread_n

bx=[]
block_n = line_n/block_item
block_x	=[*0..block_n].each{|b|bx << b*block_item}
puts "DirScanner v1.0"
puts "Hard Coded by @jmozac"
puts "http://cafelinux.info\n\n"
puts "Started At #{Time.now}"


def loaddict(r,x,y)
	inputurl  = ARGV[0].sub(/https?\:(\\\\|\/\/)(www.)?/,'')
	port = (ARGV[1]) ? (ARGV[1].to_i == 0) ? 80 : ARGV[1] : 80
	urls=inputurl.split("/")
	url=urls.shift()
	
	dirs 	=inputurl.split("/")
	dirs.shift
	dir = "/"+dirs.each{|e|}.join("/")+"/"
	
	for i in x..y
		response = nil
		Net::HTTP.start(url,port) {|http|
			response = http.head(dir+r[i])
		}
		if response.code!='404'
			puts "DirFound["+response.code+"] : "+r[i]
		end
	end
end

for i in 0..9
	t[i]=Thread.new{loaddict(rr,bx[i],block_item)}
	t[i].join
end

puts "End at #{Time.now}"
