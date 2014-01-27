# test_mars_rover.rb
# Tests for Mars Rover Kata
# Author: Jon Simpson <me@jonsimpson.co.uk>
# Date: August 22, 2013

require "./mars_rover"
require "test/unit"

class TestMarsRover < Test::Unit::TestCase

  # Tests basic function of the forward command.
  def test_forward
    rover = MarsRover.new
    rover.command('F')
    assert_equal([0,1,'N'], rover.position)
  end

  # Test basic function of the backward command.
  def test_backward
    rover = MarsRover.new(0,1,'N')
    rover.command('B')
    assert_equal([0,0,'N'], rover.position)
  end

  # Test left turn
  def test_left_turn
    rover = MarsRover.new
    rover.command('L')
    assert_equal([0,0,'NW'], rover.position)
  end

  # Test right turn
  def test_right_turn
    rover = MarsRover.new
    rover.command('R')
    assert_equal([0,0,'NE'], rover.position)
  end

  # Test multiple commands
  def test_forward_twice
    rover = MarsRover.new
    rover.command('FF')
    assert_equal([0,2,'N'], rover.position)
  end

  # Test forward after turning right.
  def test_right_forward
    rover = MarsRover.new
    rover.command('RF')
    assert_equal([1,0,'E'], rover.position)
  end

  # Test backward after turning left.
  def test_left_backward
    rover = MarsRover.new
    rover.command('LB')
    assert_equal([1,0,'NW'], rover.position)
  end

  # Test multiple turns for a complete rotation
  def test_complete_rotation
    rover = MarsRover.new
    rover.command('LLLLLLLL')
    assert_equal([0,0,'N'], rover.position)
  end

  # Kata example test - 'FFRFF' puts the rover at [0,0,'NE'].
  def test_ffrff
    rover = MarsRover.new
    rover.command('FFRFF')
    assert_equal([0,0, 'NE'], rover.position)
  end

  # Test world class exists and a default world should be 5x5
  def test_world_size
    world = World.new
    assert_equal(5, world.width)
    assert_equal(5, world.height)
  end

  # Test left edge wrapping
  # when the robot goes west at x=0, it should be at x=4 in a 5x5 world.
  def test_left_wrap
    rover = MarsRover.new(0,0,'W', world=World.new(5,5))
    rover.command('LLF')
    assert_equal([4,0,'W'], rover.position)
  end

  # Test right edge wrapping
  # when the robot goes east of x=4, it should be at x=0 in a 5x5 world
  def test_right_wrap
    rover = MarsRover.new(4,0,'E', world=World.new(5,5))
    rover.command('F')
    assert_equal([0,0,'E'], rover.position)
  end

  # Test bottom edge wrapping
  # if the robot goes below y=0, it should be at y=4 in a 5x5 world
  def test_bottom_wrap
    rover = MarsRover.new(0,0,'S', world=World.new(5,5))
    rover.command('F')
    assert_equal([0,4,'S'], rover.position)
  end

  # Test top edge wrapping
  # if the robot goes above y=4 it should be at y=0 in a 5x5 world
  # for coverage, back it off the screen instead of facing north and forward.
  def test_top_wrap
    rover = MarsRover.new(0,4,'S', world=World.new(5,5))
    rover.command('B')
    assert_equal([0,0,'S'], rover.position)
  end

  # Test world with an obstacle
  # If a world is created with an obstacle, that obstacle should be visible via world#obstacle?
  def test_world_obstacle
    world = World.new(5, 5, [ {:x => 1, :y => 1} ])
    assert_equal(true, world.obstacle?(1,1))
    assert_equal(false, world.obstacle?(0,0))
  end

  # Test robot encountering an obstacle
  def test_robot_obstacle
    world = World.new(5, 5, [{:x => 1, :y => 1}])
    rover = MarsRover.new(1,0,'N', world)
    assert_equal("Obstacle found at x:1 y:1", rover.command('F'))
  end

  # Test obstacle where x and y co-ordinates don't match
  def test_robot_obstacle_diff_coords
    world = World.new(5, 5, [{:x => 2, :y => 1}])
    rover = MarsRover.new(1,1,'E', world)
    assert_equal("Obstacle found at x:2 y:1", rover.command('F'))
  end

  # Test robot stops at obstacle.
  def test_robot_stop_obstacle
    world = World.new(5, 5, [{:x => 2, :y => 1}])
    rover = MarsRover.new(0,1,'E', world)
    message = rover.command('FFFF')
    assert_equal([1,1,'E'], rover.position)
    assert_equal("Obstacle found at x:2 y:1", message)
  end

  # Test robot & world with multiple obstacles
  def test_robot_multi_obstacle
    # Build a 3 unit high wall at x=1
    obstacles = [
      {:x => 1, :y => 0},
      {:x => 1, :y => 1},
      {:x => 1, :y => 2}
    ]
    world = World.new(5, 5, obstacles)
    rover = MarsRover.new(0,0,'E', world)
    message = rover.command('F')
    assert_equal("Obstacle found at x:1 y:0", message)
    message = rover.command('LLFRRF')
    assert_equal("Obstacle found at x:1 y:1", message)
    message = rover.command('LLFRRF')
    assert_equal("Obstacle found at x:1 y:2", message)
    message = rover.command('LLFRRF')
    assert_equal([1,3,'E'], rover.position)
  end
end
