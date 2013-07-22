class MarsRover

  # Sets initial position, default [0,0,'N']
  def initialize (x=0, y=0, heading='N')
    @x, @y = x, y
    @heading = heading
  end

  # Provides the current position
  def position
    return [@x, @y, @heading]
  end

  # Handles commands passed to the robot
  def command (command_string)
    case command_string
    when 'F'
      forward
    when 'B'
      backward
    end
  end

  # Moves the robot forward
  def forward
    case @heading
    when 'N'
      @x, @y = (@x + 1), @y
    end
  end

  # Moves the robot backwarde
  def backward
    case @heading
    when 'N'
      @x, @y = (@x - 1), @y
    end
  end

end
