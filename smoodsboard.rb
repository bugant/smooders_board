require 'rubygems'
require 'smoodit'

class SmoodsBoard
  def smooder_board_of mooders
    moods = {}
    moo = Smoodit.send(mooders.username.to_sym).smoods do |resp|
      (1..resp.pages).each do |p|
        resp.smoods(:page => p).each do |m|
          moods[m.mood] = 0 if moods[m.mood].nil?
          moods[m.mood] += 1
        end
      end
    end
    moods
  end


  def people_smoodsboard(you, kind)
    smoodboard = {}

    Smoodit.send(you.to_sym).send(kind.to_sym) do |resp|
      (1..resp.pages).each do |p|
        resp.send(kind.to_sym, :page => p).each do |f|
          moods = smooder_board_of f
          moods.each_pair do |m,q|
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
