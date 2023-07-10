# frozen_string_literal: true

class OptionL
  def initialize(option, files)
    @option = option
    @files = files
  end

  def show_detailed
    puts "total #{total_blocks(@files)}"
    @files.each do |file|
      print file_type(file)
      print file_permission(file)
      print File.stat(file).nlink.to_s.rjust(3)
      print owner(file).rjust(owner(file).length + 1)
      print group(file).rjust(group(file).length + 2)
      print File.stat(file).size.to_s.rjust(6)
      file_modification_timestamp = File.stat(file).mtime.strftime('%_m %_d %0k:%M')
      print file_modification_timestamp.rjust(file_modification_timestamp.length + 1)
      puts file.rjust(file.length + 1)
    end
  end

  def total_blocks(files)
    files.sum do |file|
      File.stat(file).blocks
    end
  end

  def file_type(file)
    {
      'directory' => 'd',
      'file' => '-',
      'link' => 'l'
    }[File.stat(file).ftype]
  end

  def file_permission(file)
    File.stat(file).mode.to_s(8).slice(-3, 3).chars.map do |char|
      {
        '7' => 'rwx',
        '6' => 'rw-',
        '5' => 'r-x',
        '4' => 'r--',
        '3' => '-wx',
        '2' => '-w-',
        '1' => '--x',
        '0' => '---'
      }[char]
    end.join
  end

  def owner(file)
    Etc.getpwuid(File.stat(file).uid).name
  end

  def group(file)
    Etc.getgrgid(File.stat(file).gid).name
  end

  def show_default
    columns = 3
    row_size = calculate_row_size(columns)
    adjust_filename_length
    @files.fill(nil, @files.length...(columns * row_size))
    @files.each_slice(row_size).to_a.transpose.each do |row|
      puts row.join(' ')
    end
  end

  def calculate_row_size(columns)
    (@files.length.to_f / columns).ceil
  end

  def adjust_filename_length
    filenames_max_length = @files.map(&:length).max
    @files = @files.map do |file|
      file.ljust(filenames_max_length)
    end
  end

  def apply_option
    @option ? show_detailed : show_default
  end
end
