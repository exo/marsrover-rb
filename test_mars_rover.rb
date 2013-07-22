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
    assert_equal([0,0,'W'], rover.position)
  end

  # Test right turn
  def test_right_turn
    rover = MarsRover.new
    rover.command('R')
    assert_equal([0,0,'E'], rover.position)
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
    assert_equal([1,0,'W'], rover.position)
  end

  # Test multiple turns for a complete rotation
  def test_complete_rotation
    rover = MarsRover.new
    rover.command('LLLL')
    assert_equal([0,0,'N'], rover.position)
  end

  # Kata example test - 'FFRFF' puts the rover at [2,2,'E'].
  def test_ffrff
    rover = MarsRover.new
    rover.command('FFRFF')
    assert_equal([2,2, 'E'], rover.position)
  end

  # Test world class exists and a default world should be 5x5
  def test_world_size
    world = World.new
    assert_equal(5, world.width)
    assert_equal(5, world.height)
  end

  # Test left edge wrapping
  # when the robot goes left at x=0, it should be at x=4 in a 5x5 world.
  def test_left_wrap
    rover = MarsRover.new(0,0,'N', world=World.new(5,5))
    rover.command('LF')
    assert_equal([4,0,'W'], rover.position)
  end

  # Test right edge wrapping
  # when the robot goes right of x=4, it should be at x=0 in a 5x5 world
  def test_right_wrap
    rover = MarsRover.new(4,0,'N', world=World.new(5,5))
    rover.command('RF')
    assert_equal([0,0,'E'], rover.position)
  end

end
