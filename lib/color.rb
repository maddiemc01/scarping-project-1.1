module Color
  def print_blue(string)
    string.colorize(:light_blue)
  end

  def print_red(string)
    string.colorize(:red)
  end

  def print_pink(string)
    string.colorize(:magenta)
  end

  def print_green(string)
    string.colorize(:green)
  end
end
