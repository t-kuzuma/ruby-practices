#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMNS = 3

# オプションを処理する
def parse_options
  opt = OptionParser.new
  flg = {}
  opt.on('-r') { flg[:r] = true }
  opt.parse!(ARGV)
  flg
end

# ファイルを取得
def read_file_based_on_options(flg)
  files = Dir.glob('*')
  flg[:r] ? files.reverse : files
end

# 列の長さを計算
def calculate_row_size(files)
  (files.size / COLUMNS.to_f).ceil
end

# ファイル名の長さの最大値を取得
def max_filename_length(files)
  files.map(&:size).max
end

# 配列の各要素の文字列の長さをmax_lengthに統一する
def ljust_filenames(files, max_length)
  files.map { |e| e.ljust(max_length) }
end

# のちにtransposeメソッドで配列を転置させるために、足りない要素数分nilを追加
def nil_plus(files, row_size)
  nil_plus_count = row_size * COLUMNS - files.size
  nil_plus_count.times { files << nil }
  files
end

# ファイルを出力する
def show_files(files, row_size)
  files.each_slice(row_size).to_a.transpose.each do |row|
    puts row.join
  end
end

flg = parse_options
files = read_file_based_on_options(flg)
row_size = calculate_row_size(files)
filenames_length = max_filename_length(files) + 2
files = ljust_filenames(files, filenames_length)
files = nil_plus(files, row_size)
show_files(files, row_size)
