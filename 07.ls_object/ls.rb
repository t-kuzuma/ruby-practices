#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'option_a'
require_relative 'option_r'
require_relative 'option_l'
require_relative 'ls_command'
require 'optparse'

opt = OptionParser.new
ls = Ls_command.new(opt)
ls.show_files
