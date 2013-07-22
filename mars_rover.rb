# World for the Mars Rover to explore, default 5x5.
class World
  attr_reader :width, :height

  def initialize (width=5, height=5, obstacles=[])
    @width = width
    @height = height
    @obstacle_map = Array.new(width) { Array.new(height) }
    obstacles.each do |obstacle|
      x, y = obstacle[:x], obstacle[:y]
      @obstacle_map[x][y] = true
    end
  end

  # Whether there is an obstacle at the given location (true/false)
  def obstacle? (x, y)
    return (@obstacle_map[x][y] != nil)
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
    begin
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
    rescue RuntimeError
      return $!.message
    end
  end

  # Moves the robot in the specified direction, according to current heading.
  def motion (direction)
    unit = (direction == :forward) ? 1 : -1;
    new_x, new_y = @x, @y
    case @heading
    when 'N'
      new_y = bound_y(@y + unit)
    when 'E'
      new_x = bound_x(@x + unit)
    when 'S'
      new_y = bound_y(@y - unit)
    when 'W'
      new_x = bound_x(@x - unit)
    end
    if @world.obstacle?(new_x, new_y)
      raise "Obstacle found at x:#{new_x} y:#{new_y}"
    else
      @x, @y = new_x, new_y
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

  # Wrap bounds appropriately for y values
  def bound_y (y)
    if y == @world.height
      return 0
    elsif y == -1
      return (@world.height - 1)
    else
      return y
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
