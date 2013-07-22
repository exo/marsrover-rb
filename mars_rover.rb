class MarsRover

  # Sets initial position, default [0,0,'N']
  def initialize (x=0, y=0, heading='N')
    @x, @y = x, y
    @heading = heading
    @headings = ['N', 'E', 'S', 'W']
  end

  # Provides the current position
  def position
    return [@x, @y, @heading]
  end

  # Handles commands passed to the robot
  def command (command_string)
    command_string.each_char do |c|
      case c
      when 'F'
        forward
      when 'B'
        backward
      when 'L'
        left
      when 'R'
        right
      end
    end
  end

  # Moves the robot forward
  def forward
    case @heading
    when 'N'
      @x, @y = @x, (@y + 1)
    end
  end

  # Moves the robot backwarde
  def backward
    case @heading
    when 'N'
      @x, @y = @x, (@y - 1)
    end
  end

  # Turn the robot left
  def left
    @heading = @headings.at(
      (@headings.index(@heading) - 1) % @headings.length
    )
  end

  # Turn the robot right
  def right
    @heading = @headings.at(
      (@headings.index(@heading) + 1) % @headings.length
    )
  end

end
