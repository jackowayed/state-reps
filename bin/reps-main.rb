#!/usr/bin/env ruby

require 'statereps'
include StateReps


peoplestr = (File.readlines ARGV[0])
people = peoplestr.map{|x|
  p = Person.new
  p.readIn(x)
  p
}
  
getReps(people)
