require "./mars_rover"
require "test/unit"

class TestMarsRover < Test::Unit::TestCase

  # Tests basic function of the forward command.
  def test_forward
    rover = MarsRover.new(0, 0, 'N')
    rover.command('F')
    assert_equal([1,0,'N'], rover.position())
  end

end
