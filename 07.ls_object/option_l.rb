# frozen_string_literal: true

class Option_l
  def initialize(option,files)
    @option = option
    @files = files
  end

  def show_detailed
    puts 'detailed'
  end

  def show_default
    columns = 3
    row_size = calculate_row_size(columns)
    adjust_filename_length
    @files.fill(nil, @files.length...(columns * row_size))
    @files.each_slice(columns).to_a.transpose.each {
      |row| puts row.join('  ')
    }
  end

  def calculate_row_size(columns)
    (@files.length.to_f / columns).ceil
  end

  def adjust_filename_length
    filenames_max_length = @files.map { |file| file.length }.max
    @files = @files.map {
      |file| file.ljust(filenames_max_length)
    }
  end

  def apply_option
    @option ? show_detailed : show_default
  end
end
