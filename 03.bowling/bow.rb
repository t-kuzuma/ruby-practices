#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
flg = 0
frames.take(9).each do |frame|
  if frame[0] == 10
    case flg
    when 3
      point += frame.sum + frame.sum + frame[0]
      flg = 3
    when 2
      point += frame.sum + frame.sum
      flg = 3
    when 1
      point += frame.sum + frame[0]
      flg = 2
    else
      point += frame.sum
      flg = 2
    end
  elsif frame.sum == 10
    point += case flg
             when 3
               frame.sum + frame.sum + frame[0]
             when 2
               frame.sum + frame.sum
             when 1
               frame.sum + frame[0]
             else
               frame.sum
             end
    flg = 1
  else
    point += case flg
             when 3
               frame.sum + frame.sum + frame[0]
             when 2
               frame.sum + frame.sum
             when 1
               frame.sum + frame[0]
             else
               frame.sum
             end
    flg = 0
  end
end

frames.drop(9).each do |frame|
  if frame[0] == 10
    case flg
    when 3
      point += frame.sum + frame.sum + frame[0]
      flg = 1
    when 2
      point += frame.sum + frame.sum
      flg = 1
    when 1
      point += frame.sum + frame[0]
      flg = 0
    else
      point += frame.sum
      flg = 0
    end
  elsif frame.sum == 10
    point += case flg
             when 3
               frame.sum + frame.sum + frame[0]
             when 2
               frame.sum + frame.sum
             when 1
               frame.sum + frame[0]
             else
               frame.sum
             end
    flg = 0
  else
    point += case flg
             when 3
               frame.sum + frame.sum + frame[0]
             when 2
               frame.sum + frame.sum
             when 1
               frame.sum + frame[0]
             else
               frame.sum
             end
    flg = 0
  end
end

puts point
