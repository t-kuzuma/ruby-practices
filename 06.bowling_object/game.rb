# frozen_string_literal: true

class Game
  def initialize(scores)
    @scores = scores
  end

  def split_into_frames
    frames = []
    frame = []

    @scores.each do |n|
      score = Shot.new(n).score
      frame << score
      if frames.size == 9
        add_frame_in_tenth(frames, frame)
      elsif n == 'X' || frame.size == 2
        frames << frame
        frame = []
      end
    end
    frames
  end

  def add_frame_in_tenth(frames, frame)
    if frame.size == 2
      frames << frame if frame.map.sum < 10
    elsif frame.size == 3
      frames << frame
    end
  end

  def convert_to_frame_objects
    split_into_frames.map do |frame|
      Frame.new(*frame)
    end
  end

  def apply_bonus_to_each_frame
    frames = convert_to_frame_objects
    frames.each_with_index do |frame, index|
      calculate_frame_bonus(frames, frame, index) if frame.score == 10 && index != 9
    end
    frames
  end

  def calculate_frame_bonus(frames, frame, index)
    if frame.first_score == 10
      calculate_strike_bonus(frames, frame, index)
    else
      calculate_spare_bonus(frames, frame, index)
    end
  end

  def calculate_strike_bonus(frames, frame, index)
    next_frame = frames[index + 1]
    bonus_score = if next_frame.first_score == 10 && index < 8
                    frames[index + 2].first_score
                  else
                    next_frame.second_score
                  end
    frame.bonus = next_frame.first_score + bonus_score
  end

  def calculate_spare_bonus(frames, frame, index)
    frame.bonus = frames[index + 1].first_score
  end

  def sum_score
    frame_scores = 0
    frames = apply_bonus_to_each_frame
    frames.each do |frame|
      frame_scores += frame.score
    end
    frame_scores
  end
end
