describe('ball', function()
  local Ball = require 'ball'
  local ball

  local function given_the_ball_is_initialized()
    ball = Ball({
      x = 50,
      y = 70,
      width = 20,
      height = 20,
      x_velocity = 5,
      y_velocity = 6
    })
  end

  local function and_the_ball_moves_to(x, y)
    ball.set_x(x)
    ball.set_y(y)
  end

  local function when_the_ball_resets()
    ball.reset()
  end

  local function the_balls_position_should_be(x, y)
    assert.are.equal(x, ball.get_x())
    assert.are.equal(y, ball.get_y())
  end

  local function the_balls_dimensions_should_be(width, height)
    assert.are.equal(width, ball.get_width())
    assert.are.equal(height, ball.get_height())
  end

  local function when_the_balls_position_changes_to(x, y)
    ball.set_x(x)
    ball.set_y(y)
  end

  local function when_the_ball_velocity_changes_to(x_velocity, y_velocity)
    ball.set_x_velocity(x_velocity)
    ball.set_y_velocity(y_velocity)
  end

  local function the_balls_velocity_should_be(x_velocity, y_velocity)
    assert.are.equal(x_velocity, ball.get_x_velocity())
    assert.are.equal(y_velocity, ball.get_y_velocity())
  end

  it('should allow initialization', function()
    given_the_ball_is_initialized()

    the_balls_position_should_be(50, 70)
    the_balls_dimensions_should_be(20, 20)
  end)

  it('should allow its position to be set', function()
    given_the_ball_is_initialized()

    when_the_balls_position_changes_to(100,40)
    the_balls_position_should_be(100, 40)
  end)

  it('should allow to reset', function()
    given_the_ball_is_initialized()
    and_the_ball_moves_to(30,100)

    when_the_ball_resets()
    the_balls_position_should_be(50, 70)
  end)

  it('should allow to change velocity', function()
    given_the_ball_is_initialized()

    when_the_ball_velocity_changes_to(30, 15)
    the_balls_velocity_should_be(30, 15)
  end)
end)
