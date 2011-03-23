require File.expand_path("../smoodsboard", __FILE__)

def usage
  puts "test_me <smooder>"
end

if ARGV.length != 1
  usage
  exit
end

smooder = ARGV[0]
puts "#{smooder} FOLLOWING smoodsboard"
board = SmoodsBoard.new.following_smoodsboard smooder
board.each_pair do |mood, stuff|
  puts "#{mood.upcase}: #{stuff[:smooder].username} (#{stuff[:points]})"
end

puts "\n#{smooder} FOLLOWERS smoodsboard"
board = SmoodsBoard.new.followers_smoodsboard smooder
board.each_pair do |mood, stuff|
  puts "#{mood.upcase}: #{stuff[:smooder].username} (#{stuff[:points]})"
end
