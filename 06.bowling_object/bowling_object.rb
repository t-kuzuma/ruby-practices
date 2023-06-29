#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'
require_relative 'game'

score = ARGV[0]
scores = score.split(',')

game = Game.new(scores)
game.split_into_frames
game.convert_to_frame_objects

game.calculate_bonus
puts game.sum_score

