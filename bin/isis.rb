#!/usr/bin/env ruby
require 'rubygems'
require 'daemons'

root_dir = File.dirname(__FILE__)
path_to_script = File.expand_path(File.join(root_dir, 'isis-run.rb'))

Daemons.run(path_to_script, :app_name => 'isis')
