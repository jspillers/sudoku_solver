# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'rake'
require 'spec/rake/spectask'
require 'rake/rdoctask'

Hoe.spec 'sudoku_solver' do |hoe|
  hoe.developer('Jarrod Spillers', 'me@jarrodspillers.com')
  hoe.rspec_options = ['--options', 'spec/spec.opts']
end

desc 'Default: run tests.'
task :default => :spec
 
desc "Run all examples"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/*_spec.rb']
end
 
desc "Build gem"
task :gem do
  sh "gem build sudoku_solver.gemspec"
end
 
desc "Run all examples with RCov"
Spec::Rake::SpecTask.new(:spec_rcov) do |t|
  t.spec_files = FileList['spec/*_spec.rb']
  t.spec_opts = ['--options', 'spec/spec.opts']
  t.rcov = true
end
 
desc 'Generate rdocs.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'Sudoku Solver'
  rdoc.main = "README.rdoc"
  rdoc.options << '--line-numbers' << '--inline-source' << '-c UTF-8'
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.rdoc_files.include('README.rdoc')
end
