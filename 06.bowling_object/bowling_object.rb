#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'
require_relative 'game'

scores = ARGV[0].split(',')

game = Game.new(scores)
puts game.sum_score
