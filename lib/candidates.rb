# this class acts as a repo for potential candidates
# for a given slot within the grid
class Candidates

  attr_accessor :x, :y, :rows

  def initialize
    tmp = []
    9.times { tmp << (0..8).inject([]) {|x,y| x << (1..9).to_a } }
    @rows = tmp
  end

  # set the x and y coordinates that we are currently working with
  def xy=(coordinates) 
    @x, @y = coordinates
  end

  def value
    @rows[@y][@x]
  end

  def value=(value)
    @rows[@y][@x] = value
  end

  def naked_singles
    @rows.each_with_index do |row, y|
      row.each_with_index do |col, x|
        if value.size == 1
          @candidates.value.first 
          @single_candidates_found += 1
          @total_values_assigned += 1
        end
      end
    end
  end

  def hidden_singles

  end
end
