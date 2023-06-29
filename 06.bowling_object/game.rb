# frozen_string_literal: true

class Game
  attr_reader :frames

  def initialize(scores)
    @scores = scores
  end

  def split_into_frames
    frames = []
    frame = []

    @scores.each do |n|
      if frames.size == 9
        if n == 'X'
          frame << 10
        else
          frame << n.to_i
        end

        if frame.size == 2
          frames << frame if (frame[0] + frame[1]) < 10
        elsif frame.size == 3
          frames << frame
        end
      else
        if n == 'X'
          frame << 10
          frames << frame
          frame = []
        elsif frame.size == 1
          frame << n.to_i
          frames << frame
          frame = []
        else
          frame << n.to_i
        end
      end
    end
    frames
  end

  def convert_to_frame_objects
    @frames = split_into_frames.map do |frame|
      Frame.new(*frame)
    end
  end

  def calculate_bonus
    @frames.each_with_index do |frame, i|
      if frame.score == 10 && i != 9
        if frame.first_shot == 10
          if @frames[i+1].first_shot == 10 && i < 8
            frame.bonus = @frames[i+1].first_shot + (@frames[i+2]&.first_shot || 0)
          else
            frame.bonus = @frames[i+1].first_shot + @frames[i+1].second_shot
          end
        else
          frame.bonus = @frames[i+1].first_shot
        end
      end
    end
  end

  def sum_score
    frame_scores = 0
    @frames.each do |frame|
      frame_scores += frame.score
    end
    frame_scores
  end
end