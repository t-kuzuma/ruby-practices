# frozen_string_literal: true

class Ls_command
  attr_reader :options

  def initialize(opt)
    @options = {}
    opt.on('-l') { @options[:l] = true }
    opt.on('-a') { @options[:a] = true }
    opt.on('-r') { @options[:r] = true }
    opt.parse!(ARGV)
  end

  def show_files
    a = Option_a.new(options[:a])
    files = a.apply_option
    r = Option_r.new(options[:r], files)
    files = r.apply_option
    l = Option_l.new(options[:l], files)
    l.apply_option
  end
end
