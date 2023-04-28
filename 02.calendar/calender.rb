#!/usr/bin/env ruby
require 'Date'
require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.on("-y Y", Integer) do |year|
    options[:year] = year
  end

  opts.on("-m M", Integer) do |month|
    options[:month] = month
  end
end.parse!

year = options[:year] || Date.today.year
month = options[:month] || Date.today.month

firstday_of_month = Date.new(year, month, 1)
lastday_of_month = Date.new(year, month, -1)

puts "#{firstday_of_month.mon}月 #{firstday_of_month.year}".center(20)

puts '日 月 火 水 木 金 土'

for num in firstday_of_month..lastday_of_month do
  # 1日のみ出力位置の調整
  if num.strftime('%-d') == "1"
    print ' '
    print '   ' * num.wday
    if num.strftime('%a') == "Sat"
      puts num.day
    else
      print num.day
    end
  else
    if num.strftime('%a') == "Sat"
      if num.strftime('%-d').to_i <= 9
        print ' '
        puts num.day
      else
        puts num.day
      end
    else
      if num.strftime('%-d').to_i <= 9
        print ' '
        print num.day
        print ' '
      else
        print num.day
        print ' '
      end
    end
  end
end

