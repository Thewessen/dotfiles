#!/usr/bin/ruby

256.times do |i|
  # Print color code in a background and foregroud color
  print "\e[48;5;#{i}m\e[38;5;15m #{"%03d" % i} "
  print "\e[33;5;0m\e[38;5;#{i}m #{"%03d" % i} "

  # Print newline to seperate the color blocks
  print "\033[0m\n" if (i + 1) <= 16 ? ((i + 1) % 8 == 0)  : (((i + 1) - 16) % 6 == 0)
  print "\033[0m\n" if (i + 1) <= 16 ? ((i + 1) % 16 == 0) : (((i + 1) - 16) % 36 == 0)
end
