return function(config)
  local x = config.x
  local y = config.y
  local width = config.width
  local height = config.height
  local boundary = config.boundary
  local paddle_speed = 0

  local function update(dt)
    if paddle_speed < 0 then
      y = math.max(boundary.upper, y + paddle_speed * dt)
    elseif paddle_speed > 0 then
      y = math.min(boundary.lower, y + paddle_speed * dt)
    end
  end

  local function get_x()
    return x
  end

  local function get_y()
    return y
  end

  local function get_width()
    return width
  end

  local function get_height()
    return height
  end

  local function idle()
    paddle_speed = 0
  end

  local function move_down(speed)
    paddle_speed = speed
  end

  local function move_up(speed)
    paddle_speed = -speed
  end

  return {
    update = update,
    get_x = get_x,
    get_y = get_y,
    set_speed = set_speed,
    get_width = get_width,
    get_height = get_height,
    move_up = move_up,
    move_down = move_down,
    idle = idle
  }
end
