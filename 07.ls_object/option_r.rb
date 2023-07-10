# frozen_string_literal: true

class OptionR
  def initialize(option, files)
    @option = option
    @files = files
  end

  def apply_option
    @option ? @files.reverse : @files
  end
end
