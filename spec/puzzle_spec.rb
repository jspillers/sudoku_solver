require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/puzzle'
 
describe Puzzle do
  before(:each) do
    @filepath = File.dirname(__FILE__) + '/puzzles/easy_1.txt'
    @puzzle = Puzzle.new(@filepath)
  end

  it "should create a new puzzle" do
    @puzzle.kind_of?(Puzzle).should be_true
  end

  it "should store the puzzle data correctly" do
    @puzzle.to_s.should eql(puzzle_file_to_s(@filepath))
  end

  it "should not be solved" do
    @puzzle.solved?.should be_false
  end

  it "should set x y coordinates correctly" do
    @puzzle.x.should eql(0)
    @puzzle.y.should eql(0)
    @puzzle.xy = [1,2]
    @puzzle.x.should eql(1)
    @puzzle.y.should eql(2)
  end

  it "should set and get individual slot values" do
    @puzzle.xy = [0,0]
    @puzzle.value.should eql(7)
    @puzzle.value = 6
    @puzzle.value.should eql(6)
  end

  it "should return the correct row" do
    @puzzle.xy = [1,2]
    @puzzle.row.should eql([5,9,4,1,0,0,0,7,0])
  end

  it "should return the correct column" do
    @puzzle.xy = [1,2]
    @puzzle.column.should eql([2,0,9,0,0,0,5,8,0])
  end

  it "should return the correct block rows" do
    @puzzle.xy = [4,5]
    @puzzle.block_rows.should eql(
      [
        [0,0,7,0,8,0,5,0,3],
        [8,0,0,2,0,6,0,0,9],
        [2,0,3,0,7,0,6,0,0]
      ]
    )
  end

  it "should return the correct block columns" do
    @puzzle.xy = [4,5]
    @puzzle.block_columns.should eql(
      [
        [0,0,1,0,2,0,0,5,6],
        [0,4,0,8,0,7,0,2,0],
        [9,2,0,0,6,0,3,0,0]
      ]
    )
  end

  it "should return the correct block" do
    @puzzle.xy = [0,5]
    @puzzle.block.should eql(
      [0,0,7,8,0,0,2,0,3]
    )
  end
end
