require 'rubygems'
require 'smoodit'

class ThreadedSmoodsBoard
  def smooder_board_of mooders
    moods = {}
    pages = 0
    threads = []
    
    Smoodit.send(mooders.username.to_sym).smoods do |resp|
      pages = resp.pages
    end
    
    (1..pages).each do |p|
      threads << Thread.new do
        Thread.current[:name] = "#{mooders.username}_#{p}/#{pages}"
        
        puts "#{Thread.current[:name]} starts..."
        
        Smoodit.send(mooders.username.to_sym).smoods(:page => p) do |resp|
          resp.smoods.each do |m|
            moods[m.mood] = 0 if moods[m.mood].nil?
            moods[m.mood] += 1
          end
        end
        
        puts "#{Thread.current[:name]} ends!"
      end
    end
    
    threads.map {|t| t.join}
    
    moods
  end


  def people_smoodsboard(you, kind)
    smoodboard = {}
    pages = 0
    
    Smoodit.send(you.to_sym).send(kind.to_sym) do |resp|
      pages = resp.pages
    end
    
    (1..pages).each do |p|
      puts "=== your #{kind} (page #{p} of #{pages}) ==="

      Smoodit.send(you.to_sym).send(kind.to_sym, :page => p) do |resp|
        resp.send(kind.to_sym).each do |f|
          moods = smooder_board_of f
          moods.each_pair do |m, q|
            smoodboard[m] = {:smooder => f, :points => q} if smoodboard[m].nil? || smoodboard[m][:points] < q
          end
        end
      end
    end
    
    smoodboard
  end

  def following_smoodsboard you
    people_smoodsboard(you, "following")
  end

  def followers_smoodsboard you
    people_smoodsboard(you, "followers")
  end
end
