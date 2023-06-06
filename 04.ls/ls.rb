#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'
require 'optparse'

COLUMNS = 3

def parse_options
  opt = OptionParser.new
  options = {}
  opt.on('-l') { options[:l] = true }
  opt.on('-a') { options[:a] = true }
  opt.on('-r') { options[:r] = true }
  opt.parse!(ARGV)
  options
end

def read_file_based_on_options(options)
  files = Dir.glob('*', options[:a] ? File::FNM_DOTMATCH : 0)
  options[:r] ? files.reverse : files
end

def show_files_based_on_options(files, options)
  if options[:l]
    show_detail(files)
  else
    show_multi_columns(files)
  end
end

def show_detail(files)
  puts "total #{total_blocks(files)}"
  files.each do |file|
    print type(file)
    print permission(file)
    print File.stat(file).nlink.to_s.rjust(3)
    print owner(file).rjust(owner(file).length + 1)
    print group(file).rjust(group(file).length + 2)
    print File.stat(file).size.to_s.rjust(6)
    file_modification_timestamp = File.stat(file).mtime.strftime('%_m %_d %0k:%M')
    print file_modification_timestamp.rjust(file_modification_timestamp.length + 1)
    puts file.rjust(file.length + 1)
  end
end

def show_multi_columns(files)
  row_size = calculate_row_size(files)
  filenames_length = max_filename_length(files) + 2
  files = files.map { |e| e.ljust(filenames_length) }
  files = nil_plus(files, row_size)
  files.each_slice(row_size).to_a.transpose.each do |row|
    puts row.join
  end
end

def calculate_row_size(files)
  (files.size / COLUMNS.to_f).ceil
end

def max_filename_length(files)
  files.map(&:size).max
end

# のちにtransposeメソッドで配列を転置させるために、足りない要素数分nilを追加
def nil_plus(files, row_size)
  nil_plus_count = row_size * COLUMNS - files.size
  nil_plus_count.times { files << nil }
  files
end

def total_blocks(files)
  files.sum do |file|
    File.stat(file).blocks
  end
end

def type(file)
  {
    'directory' => 'd',
    'file' => '-',
    'link' => 'l'
  }[File.stat(file).ftype]
end

def permission(file)
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

options = parse_options
files = read_file_based_on_options(options)
show_files_based_on_options(files, options)
