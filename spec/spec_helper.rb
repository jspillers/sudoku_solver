require 'spec'

Spec::Runner.configure do |config|
end

def puzzle_file_to_s(filepath)
  str = ""
  begin
    file = File.new(filepath, "r")
    while (line = file.gets)
      str << line
    end
    file.close
  rescue => err
    raise "you must supply a filepath for the puzzle data"
    err
  end
  str
end
