#!/usr/bin/ruby

require "puzzle"
require "candidates"
require "solver"

puzzle = Puzzle.new
puzzle.print_rows
solver = Solver.new(puzzle)
solver.solve
