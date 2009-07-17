# this class implements the various strategies needed
# to find candidates for each slot. Once every slot has been
# filled the solver will be able to ask the puzzle if it is
# solved and then output the solved puzzle
class Solver

  attr_accessor :puzzle, :candidates, 
                :single_candidates_found, :total_values_assigned

  def initialize(puzzle)
    @puzzle = puzzle
    @candidates = Candidates.new
    @single_candidates_found = 0
    @total_values_assigned = 0
  end
  
  # loop until puzzle is solved or current strategy
  # cannot move forward - then change strategy and continue
  # trying to solve
  def solve
    begin
      find_all_candidates  
      execute_strategy
    end while @single_candidates_found > 0 && @puzzle.solved? == false

    if @puzzle.solved?
      @puzzle.print_rows
    else
      puts "could not solve"
      puts "assigned #{@total_values_assigned}"
      @puzzle.print_rows
    end
  end
  
  # loops through every slot in the puzzle
  # grid and determines the possible candidates 
  # for each
  def find_all_candidates
    @single_candidates_found = 0
    loop_xy do |x,y|
      find_candidates_for(x,y)
    end
  end

  # examine the puzzle object and determines all 
  # candidates for each slot in the puzzle grid (x,y)
  # using the current solving strategy
  def find_candidates_for(x,y)
    @puzzle.xy = [x,y]
    @candidates.xy = [x,y]

    @candidates.value = if @puzzle.value == 0
      @candidates.value - (@puzzle.block | @puzzle.row | @puzzle.column)
    else
      [ @puzzle.value ]
    end
  end

  def execute_strategy
    naked_singles  
  end

  def find_naked_singles
    loop_xy do |x,y|
      @puzzle.xy = [x,y]
      @candidates.xy = [x,y]

      # if only one candidate exists for a given slot and it is 
      # not one of the originally given numbers then assign it to the puzzle
      if @candidates.value.size == 1 && @puzzle.value == 0
        @puzzle.value = @candidates.value.first 
        @single_candidates_found += 1
        @total_values_assigned += 1
      end
    end
  end

  def find_hidden_singles
    @candidates.each_block.each do |block|
      # find the hidden singles
    end
  end

  protected

  def loop_xy
    (0..8).each do |y|
      (0..8).each do |x|
        yield(x,y)
      end
    end
  end

end
