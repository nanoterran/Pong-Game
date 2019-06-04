describe('paddle', function()
  local Paddle = require 'paddle'
  local paddle

  local function given_the_paddle_is_initialized()
    paddle = Paddle({
      x = 5,
      y = 10,
      width = 20,
      height = 100,
      boundary = {
        upper = 5,
        lower = 500
      }
    })
  end

  local function request_paddle_to_move_down_at(speed)
    paddle.move_down(speed)
  end

  local function the_paddles_y_possition_should_be(y_position)
    assert.equal(y_position, paddle.get_y())
  end

  local function request_paddle_to_move_up_at(speed)
    paddle.move_up(speed)
  end

  local function after_updating_the_paddle()
    paddle.update(1)
  end

  local function after_updating_the_paddle_many_times()
    for i = 1, 10 do
      paddle.update(1)
    end
  end

  local function request_paddle_to_be_idle()
    paddle.idle()
  end

  it('should be able to set paddle position and dimentions', function()
    given_the_paddle_is_initialized()

    assert.equal(5, paddle.get_x())
    assert.equal(10, paddle.get_y())
    assert.equal(20, paddle.get_width())
    assert.equal(100, paddle.get_height())
  end)

  it('should be able to move down after update', function()
    given_the_paddle_is_initialized()

    request_paddle_to_move_down_at(200)

    after_updating_the_paddle()
    the_paddles_y_possition_should_be(210)
  end)

  it('should be able to move up after update', function()
    given_the_paddle_is_initialized()

    request_paddle_to_move_up_at(2)

    after_updating_the_paddle()
    the_paddles_y_possition_should_be(8)
  end)

  it('should be able to stay idle when requested', function()
    given_the_paddle_is_initialized()

    request_paddle_to_be_idle()

    after_updating_the_paddle_many_times()
    the_paddles_y_possition_should_be(10)
  end)

  it('should not move above upper boundary', function()
    given_the_paddle_is_initialized()

    request_paddle_to_move_up_at(10)
    after_updating_the_paddle()

    the_paddles_y_possition_should_be(5)
  end)

  it('should not move below lower boundary', function()
    given_the_paddle_is_initialized()

    request_paddle_to_move_down_at(600)
    after_updating_the_paddle()

    the_paddles_y_possition_should_be(500)
  end)
end)
