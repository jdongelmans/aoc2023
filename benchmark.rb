#!/usr/bin/ruby

require 'benchmark'

def v1; end

def v2; end

Benchmark.bmbm do |job|
  job.report("v1") { 500.times { v1 } }
  job.report("v2") { 500.times { v2 } }
end
