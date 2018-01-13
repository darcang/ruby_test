#!/usr/bin/env ruby

require './lib/system_dependencies'
require './lib/commands'

text_file = ARGV[0]

raise 'Please pass an input file' unless text_file

puts Agile::SystemDependencies.new(text_file).perform
