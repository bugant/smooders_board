require 'benchmark'
require File.expand_path("../smoods_board", __FILE__)
require File.expand_path("../threaded_smoods_board", __FILE__)

def usage
  puts "Usage: ruby test_me.rb <smooder>"
end

if ARGV.length != 1
  usage
  exit
end

result = ""
bm_result = ""

bm_result << "\n\nthreaded: " + Benchmark.measure {
  result << "\n\nYour FOLLOWING smoodsboard"
  board = ThreadedSmoodsBoard.new.following_smoodsboard ARGV[0]
  board.each_pair do |mood, stuff|
    result << "\n#{mood.upcase}: #{stuff[:smooder].username} (#{stuff[:points]})"
  end
}.format("%r")

bm_result << "\nnormal: " + Benchmark.measure {
  result << "\n\nYour FOLLOWING smoodsboard"
  board = SmoodsBoard.new.following_smoodsboard ARGV[0]
  board.each_pair do |mood, stuff|
    result << "\n#{mood.upcase}: #{stuff[:smooder].username} (#{stuff[:points]})"
  end
}.format("%r")

# puts Benchmark.measure {
#   result << "\n\nYour FOLLOWERS smoodsboard"
#   board = SmoodsBoard.new.followers_smoodsboard ARGV[0]
#   board.each_pair do |mood, stuff|
#     result << "\n#{mood.upcase}: #{stuff[:smooder].username} (#{stuff[:points]})"
#   end
# }

puts result

puts bm_result