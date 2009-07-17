require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/puzzle'
require File.dirname(__FILE__) + '/../lib/candidates'
require File.dirname(__FILE__) + '/../lib/solver'
 
describe Solver do
  before(:each) do
    @puzzle = Puzzle.new(File.dirname(__FILE__) + '/puzzles/easy_1.txt')
    @solution = Puzzle.new(File.dirname(__FILE__) + '/puzzles/easy_1_solution.txt')
    @solver = Solver.new(@puzzle)
  end

  it "should create a new solver" do
    @solver.kind_of?(Solver).should be_true
  end

  it "puzzle should contain the correct number of preset numbers" do
    @solver.puzzle.rows.flatten.delete_if {|x| x == 0 }.size.should eql(36)
  end

  it "should set the correct candidates for a given slot" do
    @solver.find_candidates_for(1,8).should eql([1,4,7])
    @solver.single_candidates_found.should eql(0)
  end

  it "should find all candidates" do
    @solver.find_all_candidates
    @solver.candidates.rows.flatten.should eql(
      [7,2,6,8,3,8,3,5,6,9,3,8,3,4,8,1,1,1,3,1,8,3,7,8,4,2,3,8,9,6,5,5,9,4,1,3,6,8,2,
       3,8,7,2,1,4,6,9,1,4,6,7,4,9,8,1,4,5,1,2,4,3,8,1,4,1,5,2,1,3,5,6,1,7,1,4,9,2,1,
       4,3,4,9,7,1,4,5,6,1,4,8,4,1,6,5,1,2,6,8,1,3,4,9,7,1,4,6,9,8,1,6,9,5,2,1,4,7,1,
       3,1,3,6,3,1,4,7,1,2,9,6,1,9,1,4,7,1,2,5,8]
    )
  end

  it "candidates should contain the correct naked single candidates" do
    @solver.find_all_candidates

    (0..8).each do |x|
      (0..8).each do |y|
        @solver.candidates.xy = [x,y]
        @solution.xy = [x,y]
        if @solver.candidates.value.size == 1
          @solver.candidates.value.first.should eql(@solution.value)
        end
      end
    end
  end

  it "should assign all naked single candidates back to the puzzle" do
    @solver.puzzle.rows.flatten.delete_if {|x| x == 0 }.size.should eql(36)
    @solver.find_all_candidates
    @solver.find_naked_singles
    @solver.single_candidates_found.should eql(8)
    @solver.puzzle.rows.flatten.delete_if {|x| x == 0 }.size.should eql(44)
  end

  it "candidates should contain the correct hidden single candidates" do

  end

  it "should assign all hidden single candidates back to the puzzle" do

  end

 #it "should solve an easy puzzle" do
 #  @solver.solve
 #  @puzzle.rows.should eql(@solution.rows)
 #end
end
