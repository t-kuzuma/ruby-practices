# frozen_string_literal: true

class Frame
  attr_reader :first_shot, :second_shot, :third_shot
  attr_accessor :bonus

  def initialize(first_shot, second_shot = 0, third_shot = 0)
    @first_shot = first_shot
    @second_shot = second_shot
    @third_shot = third_shot
    @bonus = 0
  end

  def score
    first_score = Shot.new(first_shot).score
    second_score = Shot.new(second_shot).score
    third_score = Shot.new(third_shot).score
    first_score + second_score + third_score + @bonus
  end
end