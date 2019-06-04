describe('ball', function()
  local Ball = require 'ball'
  local ball

  local function given_the_ball_is_initialized()
    ball = Ball({
      x = 50,
      y = 70,
      width = 20,
      height = 20,
      boundary = {}
    })
  end

  it('should be able to set ball position and dimension', function()
    given_the_ball_is_initialized()

    assert.equal(50, ball.get_x())
    assert.equal(70, ball.get_y())
    assert.equal(20, ball.get_width())
    assert.equal(20, ball.get_height())
  end)
end)
