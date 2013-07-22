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
    rover = MarsRover.new(0,0,'N')
    rover.command('LB')
    assert_equal([1,0,'W'], rover.position)
  end

end
