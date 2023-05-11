#!/usr/bin/env ruby
# frozen_string_literal: true

files = Dir.glob('*')
columns = 3
row_size = (files.size / columns.to_f).ceil

# ファイル名の長さの最大値を取得
def max_filename_length(files)
  max_length = 0
  files.each do |e|
    max_length = e.size if e.size > max_length
  end
  max_length
end

# 配列の各要素の文字列の長さをmax_lengthに統一する
def ljust_filenames(files, max_length)
  files.map { |e| e.ljust(max_length) }
end

# のちにtransposeメソッドで配列を転置させるために、足りない要素数分nilを追加
def nil_plus(files, columns, row_size)
  nil_plus_count = row_size * columns - files.size
  nil_plus_count.times { files << nil }
  files
end

filenames_length = max_filename_length(files) + 2
files = ljust_filenames(files, filenames_length)
files = nil_plus(files, columns, row_size)
files.each_slice(row_size).to_a.transpose.each do |row|
  puts row.join
end
