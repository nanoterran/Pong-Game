return function(config)
  local x = config.x
  local y = config.y
  local width = config.width
  local height = config.height
  local dx = math.random(2) == 1 and 100 or -100
  local dy = math.random(-50, 50)

  local function reset()
    dx = math.random(2) == 1 and 100 or -100
    dy = math.random(-50, 50)
    x = config.screen.width / 2 - 2
    y = config.screen.height / 2 - 2
  end

  local function update(dt)
    x = x + dx * (dt * 3)
    y = y + dy * (dt * 3)
  end

  local function collides(paddle)
    if x > paddle.get_x() + paddle.get_width() or paddle.get_x() > x + width then
      return false
    end

    if y > paddle.get_y() + paddle.get_height() or paddle.get_y() > y + height then
      return false
    end

    return true
  end

  local function get_x()
    return x
  end

  local function set_x(new_x)
    x = new_x
  end

  local function set_y(new_y)
    y = new_y
  end

  local function get_y()
    return y
  end

  local function get_dx()
    return dx
  end

  local function set_dx(new_dx)
    dx = new_dx
  end

  local function get_dy()
    return dy
  end

  local function set_dy(new_dy)
    dy = new_dy
  end

  local function get_width()
    return width
  end

  local function get_height()
    return height
  end

  return {
    get_x = get_x,
    set_x = set_x,
    get_y = get_y,
    set_y = set_y,
    get_dx = get_dx,
    set_dx = set_dx,
    get_dy = get_dy,
    set_dy = set_dy,
    get_width = get_width,
    get_height = get_height,
    reset = reset,
    update = update,
    collides = collides
  }
end
