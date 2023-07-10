# frozen_string_literal: true

class OptionA
  def initialize(option)
    @option = option
  end

  def apply_option_and_get_files
    @option ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
  end
end
