# this class is responsible for 
# - storing the puzzle data
# - the methods necessary to access rows, columns,
#   blocks of rows/columns and the invidual blocks
# - analyzing a puzzle to determine if it is solved
#
# this is an example of how the puzzle data is stored within this object
#
# [ 
#   [ # calling this is a block row
#     [[0,1,0], [7,0,4], [0,8,0]], # and this is a block sub row
#     [[2,0,0], [5,3,1], [0,0,9]], # each triplet is referred to as a block column
#     [[0,0,0], [0,0,0], [0,0,0]],
#   ],
#   [
#     [[1,2,0], [0,0,0], [0,5,6]],
#     [[0,6,0], [0,0,0], [0,9,0]],
#     [[9,4,0], [0,0,0], [0,3,7]],
#   ],
#   [
#     [[0,0,0], [0,0,0], [0,0,0]],
#     [[8,0,0], [6,7,3], [0,0,2]],
#     [[0,5,0], [1,0,9], [0,4,0]]
#   ]
# ]
#
# when creating a new puzzle a file path
# must be supplied in this format with 0's
# to represent empty cells:
#
#     7 2 0 0 0 9 0 0 1
#     0 0 0 0 4 2 0 6 0
#     5 9 4 1 0 0 0 7 0
#     0 0 7 0 8 0 5 0 3
#     8 0 0 2 0 6 0 0 9
#     2 0 3 0 7 0 6 0 0
#     0 5 0 0 0 3 4 9 7
#     0 8 0 5 2 0 0 0 0
#     3 0 0 6 0 0 0 5 8
#
class Puzzle

  attr_accessor :x, :y, :rows, :candidates

  def initialize(filepath)
    init_rows
    tmp_rows = parse_file(filepath)
    parse_rows(tmp_rows)
    @x = 0
    @y = 0
    @solved = false
  end
 
  # set the x and y coordinates that we are currently working with
  def xy=(coordinates) 
    @x, @y = coordinates
  end

  # returns an array of the entire row for the current x,y
  def row
    @rows[block_row][block_sub_row].inject([]) {|j,k| j += k }
  end

  # returns an array of the entire column for which the x,y belongs
  def column
    column = []
    @rows.each do |block_row|
      block_row.each do |block_sub_row|
        column << block_sub_row[block_column][block_sub_column]
      end
    end
    column
  end

  # returns an array of the block of rows for which the x,y belongs
  def block_rows
    rows = []
    (0..2).each do |block_sub_row|
      rows << @rows[block_row][block_sub_row].inject([]) {|j,k| j += k }
    end
    rows
  end

  # returns an array of the block of columns for which the x,y belongs
  def block_columns
    columns = [[],[],[]]
    @rows.each do |block_row|
      block_row.each do |block_sub_row|
        (0..2).each do |block_sub_column|
          columns[block_sub_column] << block_sub_row[block_column][block_sub_column]
        end
      end
    end
    columns
  end

  # returns an array of the block of which the x,y is a member
  def block
    block_array = []
    @rows[block_row].each do |block_sub_row|
      block_array += block_sub_row[block_column]  
    end
    block_array
  end

  # assigns a block - accepts a single array of values
  def block=(block_array)
    tmp = []
    tmp[0] = block_array[0..2]
    tmp[1] = block_array[3..5]
    tmp[2] = block_array[6..8]

    tmp.each_with_index do |values,i|
      @rows[block_row][i][block_column] = values
    end
  end

  # assigns whole blocks - accepts an array of arrays
  def blocks=(blocks_array)
    i = 0
    [0,3,6].each do |y|
      [0,3,6].each do |x|
        self.xy = [x,y]
        self.block = blocks_array[i]
        i += 1
      end
    end
  end

  # returns the blocks as an array of arrays
  def each_block
    blocks_array = []
    [0,3,6].each do |y|
      [0,3,6].each do |x|
        self.xy = [x,y]
        blocks_array << self.block
      end
    end
    blocks_array
  end

  # get the value for a specific slot in the grid
  def value
    @rows[block_row][block_sub_row][block_column][block_sub_column]
  end

  # set the value of a specific slot in the grid
  def value=(value)
    @rows[block_row][block_sub_row][block_column][block_sub_column] = value
  end

  # returns the puzzle in a string representation
  def to_s
    rows = ""
    @rows.each do |block_row|
      block_row.each do |block_sub_row|
        rows << block_sub_row.flatten.join(" ") + "\n"
      end
    end
    rows
  end

  def solved?
    (0..8).each do |y|
      @x = 0; @y = y;
      return false unless row.inject(0) {|a,b| a += b } == 45
    end

    (0..8).each do |x|
      @x = x; @y = 0;
      return false unless column.inject(0) {|a,b| a += b } == 45
    end

    (0..8).each do |x|
      (0..8).each do |y|
        @x = x; @y = y;
        return false unless block.inject(0) {|a,b| a += b } == 45
      end
    end
    @solved = true
  end

  protected

  def block_row
    (@y.to_f / 3.0).to_i
  end

  def block_sub_row
    @y - block_row * 3
  end

  def block_column
    (@x.to_f / 3.0).to_i
  end

  def block_sub_column
    @x - block_column * 3
  end

  def parse_file(filepath)
    file_rows = []
    begin
      file = File.new(filepath, "r")
      while (line = file.gets)
        file_rows << line.split(" ").map{ |x| x.to_i }
      end
      file.close
    rescue => err
      raise "you must supply a filepath for the puzzle data"
      err
    end
    file_rows
  end

  def parse_rows(rows)
    rows.each_with_index do |row,y|
      row.each_with_index do |val,x|
        self.xy = [x,y]
        self.value = val
      end
    end
  end

  # create the array structure in which we will 
  # store our puzzle data
  def init_rows
    @rows = [
      [
        [[],[],[]],
        [[],[],[]],
        [[],[],[]]
      ],
      [
        [[],[],[]],
        [[],[],[]],
        [[],[],[]]
      ],
      [
        [[],[],[]],
        [[],[],[]],
        [[],[],[]]
      ]
    ]
  end
end
