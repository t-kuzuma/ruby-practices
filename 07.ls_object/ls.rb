#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'option_a'
require_relative 'option_r'
require_relative 'option_l'
require_relative 'ls_command'
require 'optparse'
require 'etc'

opt = OptionParser.new
ls = LsCommand.new(opt)
ls.show_files
