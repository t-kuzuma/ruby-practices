# frozen_string_literal: true

class LsCommand
  def initialize
    @options = {}
    opt = OptionParser.new
    opt.on('-l') { @options[:l] = true }
    opt.on('-a') { @options[:a] = true }
    opt.on('-r') { @options[:r] = true }
    opt.parse!(ARGV)
  end

  def files_with_a_option
    a = OptionA.new(@options[:a])
    a.apply_option_and_get_files
  end

  def apply_r_option_to_files(files)
    r = OptionR.new(@options[:r], files)
    r.apply_option
  end

  def print_file_with_l_option(files)
    l = OptionL.new(@options[:l], files)
    l.apply_option_and_print_files
  end

  def show_files
    files = files_with_a_option
    files = apply_r_option_to_files(files)
    print_file_with_l_option(files)
  end
end
