# World for the Mars Rover to explore, default 5x5.
class World
  attr_reader :width, :height

  def initialize (width=5, height=5)
    @width = width
    @height = height
  end

end

class MarsRover

  # Sets initial position, default [0,0,'N'] and world.
  def initialize (x=0, y=0, heading='N', world=World.new)
    @x, @y = x, y
    @heading = heading
    @headings = ['N', 'E', 'S', 'W']
    @world = world
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
        motion(:forward)
      when 'B'
        motion(:backward)
      when 'L'
        left
      when 'R'
        right
      end
    end
  end

  # Moves the robot in the specified direction, according to current heading.
  def motion (direction)
    unit = (direction == :forward) ? 1 : -1;
    case @heading
    when 'N'
      @y = @y + unit
    when 'E'
      @x = bound_x(@x + unit)
    when 'S'
      @y = @y - unit
    when 'W'
      @x = bound_x(@x - unit)
    end
  end

  # Wrap bounds appropriately for x values
  def bound_x (x)
    if x == @world.width
      return 0
    elsif x == -1
      return (@world.width - 1)
    else
      return x
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
