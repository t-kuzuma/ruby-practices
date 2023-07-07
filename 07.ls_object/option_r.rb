# frozen_string_literal: true

class Option_r
  def initialize(option, files)
    @option = option
    @files = files
  end

  def apply_option
    @option ? @files.reverse : @files
  end
end
