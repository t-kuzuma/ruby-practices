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

frames = shots.each_slice(2).map { |s| { first: s[0], second: s[1], bonus: 0 } }

# エラー回避：10フレーム目でスペアが出た時11フレーム目の:secondに0を入れる
frames[10][:second] = 0 if frames[9][:first] + frames[9][:second] == 10 && frames[9][:first] != 10

frames.each_with_index do |frame, index|
  # 9フレーム目まではボーナス換算
  # それ以降は不要
  break if index >= 9
  next_frame = frames[index + 1]

  if frame[:first] == 10
    # ストライクの場合
    frame[:bonus] = next_frame[:first] + (next_frame[:first] == 10 ? frames[index + 2][:first] : next_frame[:second])
  elsif frame[:first] + frame[:second] == 10
    # スペアの場合
    frame[:bonus] = next_frame[:first]
  end
end

total = frames.sum { |frame| [:first, :second, :bonus].sum { |key| frame[key] } }
puts total
