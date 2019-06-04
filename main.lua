local Ball = require 'src.ball'
local Paddle = require 'src.paddle'
local Screen = require 'src.screen'

local const = {
  paddle_speed = 400,
  paddle_width = 10,
  paddle_height = 70,
  screen_width = 1280,
  screen_height = 720
}

local score = {
  player_one = 0,
  player_two = 0
}

local screen = Screen({
  width = 1280,
  height = 720
})

function love.load()
  love.window.setMode(screen.width, screen.height, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  love.window.setTitle('Pong')

  love.graphics.setDefaultFilter('nearest', 'nearest')

  small_font = love.graphics.newFont(32)
  large_font = love.graphics.newFont(64)
  score_font = love.graphics.newFont(64)
  love.graphics.setFont(small_font)

  math.randomseed(os.time())

  player_one = Paddle({
    x = 30,
    y = 30,
    width = const.paddle_width,
    height = const.paddle_height,
    boundary = {
      upper = 10,
      lower = const.screen_height - 80
    }
  })
  player_two = Paddle({
    x = screen.width - 40,
    y = screen.height - 100,
    width = const.paddle_width,
    height = const.paddle_height,
    boundary = {
      upper = 10,
      lower = const.screen_height - 80
    }
  })
  ball = Ball({
    x = screen.width / 2 - 2,
    y = screen.height / 2 - 2,
    width = 15,
    height = 15,
    screen = screen
  })

  serving_player = 1

  game_state = 'start'
end


function love.update(dt)
  if game_state == 'serve' then
    ball.set_dy(math.random(-50, 50))

    if serving_player == 1 then
      ball.set_dy(math.random(140, 200))
    else
      ball.set_dx(-math.random(140, 200))
    end
  elseif game_state == 'play' then

    if ball.collides(player_one) then
      ball.set_dx( -ball.get_dx() * 1.03 )
      ball.set_x( player_one.get_x() + (ball.get_width() + 1) )

      if ball.get_dy() < 0 then
        ball.set_dy( -math.random(10, 150) )
      else
        ball.set_dy( math.random(10, 150) )
      end
    end

    if ball.collides(player_two) then
      ball.set_dx( -ball.get_dx() * 1.03 )
      ball.set_x( player_two.get_x() - ball.get_width() )

      if ball.get_dy() < 0 then
        ball.set_dy( -math.random(10, 150) )
      else
        ball.set_dy( math.random(10, 150) )
      end
    end

    if ball.get_y() <= 0 then
      ball.set_y(0)
      ball.set_dy( -ball.get_dy() )
    end

    if ball.get_y() >= screen.height - ball.get_width() then
      ball.set_y( screen.height - ball.get_width() )
      ball.set_dy( -ball.get_dy() )
    end

    if ball.get_x() < 0 then
      serving_player = 1
      score.player_two = score.player_two + 1

      sounds['score']:play()

      if score.player_two == 10 then
        winning_player = 2
        game_state = 'done'
      else
        game_state = 'serve'
        ball:reset()
      end
    end

    if ball.get_x() > screen.width then
      serving_player = 2
      score.player_one = score.player_one + 1

      sounds['score']:play()

      if score.player_one == 10 then
        winning_player = 1
        game_state = 'done'
      else
        game_state = 'serve'
        ball:reset()
      end
    end
  end

  if love.keyboard.isDown('w') then
    player_one.move_up(const.paddle_speed)
  elseif love.keyboard.isDown('s') then
    player_one.move_down(const.paddle_speed)
  else
    player_one.idle()
  end

  if love.keyboard.isDown('up') then
    player_two.move_up(const.paddle_speed)
  elseif love.keyboard.isDown('down') then
    player_two.move_down(const.paddle_speed)
  else
    player_two.idle()
  end

  if game_state == 'play' then
    ball.update(dt)
  end

  player_one.update(dt)
  player_two.update(dt)
end

function love.keypressed( key, scancode, isrepeat )
  if key == 'q' then
    love.event.quit()
  elseif key == 'return' then
    if game_state == 'start' then
      game_state = 'serve'
    elseif game_state == 'serve' then
      game_state = 'play'
    elseif game_state == 'done' then
      game_state = 'serve'
      ball.reset()

      score.player_one = 0
      score.player_two = 0

      if winning_player == 1 then
        serving_player = 2
      else
        serving_player = 1
      end
    end
  end
end

function love.draw()
  love.graphics.setFont(small_font)

  if game_state == 'start' then
    draw_start_screen()
  elseif game_state == 'serve' then
    draw_serve_screen()
  elseif game_state == 'play' then
    display_score_at(screen.height / 8)
  elseif game_state == 'done' then
    draw_done_screen()
  end

  draw_paddle_for(player_one)
  draw_paddle_for(player_two)
  draw_ball()
end

function display_score_at(height)
  love.graphics.setFont(score_font)
  love.graphics.print(
    tostring(score.player_one),
    screen.width / 2 - 100,
    height
  )
  love.graphics.print(
    tostring(score.player_two),
    screen.width / 2 + 50,
    height
  )
end

function draw_paddle_for(player)
  love.graphics.rectangle(
    'fill',
    player.get_x(),
    player.get_y(),
    player.get_width(),
    player.get_height()
  )
end

function draw_ball(draw)
  love.graphics.rectangle(
    'fill',
    ball.get_x(),
    ball.get_y(),
    ball.get_width(),
    ball.get_height()
  )
end

function draw_done_screen()
  love.graphics.setFont(large_font)
  love.graphics.printf(
    'Player ' .. tostring(winning_player) .. ' wins!',
    0,
    30,
    screen.width,
    'center'
  )
  love.graphics.setFont(small_font)
  love.graphics.printf('Press Enter to restart!', 0, 100, screen.width, 'center')

  display_score_at(screen.height / 3)
end

function draw_serve_screen()
  love.graphics.setFont(small_font)
  love.graphics.printf(
    'Player ' .. tostring(serving_player) .. "'s serve!",
    0,
    30,
    screen.width,
    'center'
  )
  love.graphics.printf('Press Enter to serve!', 0, 80, screen.width, 'center')

  display_score_at(screen.height / 3)
end
function draw_start_screen()
  love.graphics.setFont(small_font)
  love.graphics.printf('Welcome to Pong!', 0, 30, screen.width, 'center')
  love.graphics.printf('Press Enter to begin!', 0, 80, screen.width, 'center')

  display_score_at(screen.height / 3)
end
