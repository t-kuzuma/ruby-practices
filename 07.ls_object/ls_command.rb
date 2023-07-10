# frozen_string_literal: true

class LsCommand
  def initialize(opt)
    @options = {}
    opt.on('-l') { @options[:l] = true }
    opt.on('-a') { @options[:a] = true }
    opt.on('-r') { @options[:r] = true }
    opt.parse!(ARGV)
  end

  def show_files
    a = OptionA.new(@options[:a])
    files = a.apply_option
    r = OptionR.new(@options[:r], files)
    files = r.apply_option
    l = OptionL.new(@options[:l], files)
    l.apply_option
  end
end
