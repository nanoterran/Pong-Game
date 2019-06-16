return function(config)
  local x = config.x
  local y = config.y
  local width = config.width
  local height = config.height
  local x_velocity = config.x_velocity
  local y_velocity = config.y_velocity
  local starting_x = config.x
  local starting_y = config.y

  local function reset()
    x_velocity = x_velocity
    y_velocity = y_velocity
    x = starting_x
    y = starting_y
  end

  local function update(dt)
    x = x + x_velocity * (dt * 3)
    y = y + y_velocity * (dt * 3)
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

  local function get_x_velocity()
    return x_velocity
  end

  local function set_x_velocity(velocity)
    x_velocity = velocity
  end

  local function get_y_velocity()
    return y_velocity
  end

  local function set_y_velocity(velocity)
    y_velocity = velocity
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
    get_x_velocity = get_x_velocity,
    set_x_velocity = set_x_velocity,
    get_y_velocity = get_y_velocity,
    set_y_velocity = set_y_velocity,
    get_width = get_width,
    get_height = get_height,
    reset = reset,
    update = update,
    collides = collides
  }
end
