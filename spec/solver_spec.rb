require File.dirname(__FILE__) + '/spec_helper'

["solver", "puzzle", "candidates", "puzzle_data"].each do |filename|
  require File.dirname(__FILE__) + "/../lib/#{filename}"
end
 
describe Solver do
  before(:each) do
    @puzzle = Puzzle.new
    @solver = Solver.new(@puzzle)
  end

  it "should create a new solver" do
    @solver.kind_of?(Solver).should be_true
  end
end
