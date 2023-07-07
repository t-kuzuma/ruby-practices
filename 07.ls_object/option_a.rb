# frozen_string_literal: true

class Option_a
  def initialize(option)
    @option = option
  end

  def apply_option
    @option ? Dir.glob("*", File::FNM_DOTMATCH) : Dir.glob("*")
  end
end
