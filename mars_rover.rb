class MarsRover

  def initialize (x, y, heading)
    @x, @y = x, y
    @heading = heading
  end

  def position
    return [@x, @y, @heading]
  end

  def command (command_string)
    case command_string
    when 'F'
      forward
    end
  end

  def forward
    case @heading
    when 'N'
      @x, @y = (@x + 1), @y
    end
  end

end
