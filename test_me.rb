require File.expand_path("../smoodsboard", __FILE__)

def usage
  puts "test_me <smooder>"
end

if ARGV.length != 1
  usage
  exit
end

puts "Your FOLLOWING smoodsboard"
board = SmoodsBoard.new.following_smoodsboard ARGV[0]
board.each_pair do |mood, stuff|
  puts "#{mood.upcase}: #{stuff[:smooder].username} (#{stuff[:points]})"
end

puts "\nYour FOLLOWERS smoodsboard"
board = SmoodsBoard.new.followers_smoodsboard ARGV[0]
board.each_pair do |mood, stuff|
  puts "#{mood.upcase}: #{stuff[:smooder].username} (#{stuff[:points]})"
end
