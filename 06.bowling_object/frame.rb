# frozen_string_literal: true

class Frame
  attr_reader :first_score, :second_score, :third_score
  attr_accessor :bonus

  def initialize(first_score, second_score = 0, third_score = 0)
    @first_score = first_score
    @second_score = second_score
    @third_score = third_score
    @bonus = 0
  end

  def score
    first_score + second_score + third_score + bonus
  end
end
