require File.expand_path("../smoodsboard", __FILE__)

def usage
  puts "Usage: ruby test_me.rb <smooder>"
end

if ARGV.length != 1
  usage
  exit
end

smooder = ARGV[0]
result = "\n#{smooder} FOLLOWING smoodsboard"
board = SmoodsBoard.new.following_smoodsboard ARGV[0]
board.each_pair do |mood, stuff|
  result << "\n#{mood.upcase}: #{stuff[:smooder].username} (#{stuff[:points]})"
end

result << "\n#{smooder} FOLLOWERS smoodsboard"
board = SmoodsBoard.new.followers_smoodsboard ARGV[0]
board.each_pair do |mood, stuff|
  result << "\n#{mood.upcase}: #{stuff[:smooder].username} (#{stuff[:points]})"
end

puts result
