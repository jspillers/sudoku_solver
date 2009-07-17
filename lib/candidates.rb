# this class acts as a repo for potential candidates
# for a given slot within the grid
class Candidates < Puzzle

  attr_accessor :rows

  def initialize
    init_rows
    @x = 0
    @y = 0
  end

  protected

  def init_rows
    super
    (0..8).each do |y|
      (0..8).each do |x|
        self.xy = [x,y]
        self.value = (1..9).to_a
      end
    end  
  end

end
