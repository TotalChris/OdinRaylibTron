package main;

import "core:fmt";
import "core:math/rand";
import rl "vendor:raylib";

poll_input :: proc(game: ^GameState)
{
  #partial switch key := rl.GetKeyPressed(); key {
    case rl.KeyboardKey.UP, rl.KeyboardKey.W:
      if(game.player.direction != PlayerDirection.Down) {
        game.player.direction = PlayerDirection.Up;
      }
      break;
    case rl.KeyboardKey.DOWN, rl.KeyboardKey.S:
      if(game.player.direction != PlayerDirection.Up) {
        game.player.direction = PlayerDirection.Down;
      }
      break;
    case rl.KeyboardKey.LEFT, rl.KeyboardKey.A:
      if(game.player.direction != PlayerDirection.Right) {
        game.player.direction = PlayerDirection.Left;
      }
      break;
    case rl.KeyboardKey.RIGHT, rl.KeyboardKey.D:
      if(game.player.direction != PlayerDirection.Left) {
        game.player.direction = PlayerDirection.Right;
      }
      break;
    case rl.KeyboardKey.SPACE:
      if game.runState == RunState.Running {
        game.runState = RunState.Paused;
      } else if game.runState == RunState.Paused || game.runState == RunState.Stopped {
        game.runState = RunState.Running;
      }
      break;
    case:
      // No action for other keys
      break;
  }
}

update_player :: proc(game: ^GameState)
{
  if game.runState != RunState.Running {
    return;
  }

  switch game.player.direction {
    case PlayerDirection.Up:
      game.player.position.y -= game.player.speed / 60; // Adjust for frame rate
      break;
    case PlayerDirection.Down:
      game.player.position.y += game.player.speed / 60;
      break;
    case PlayerDirection.Left:
      game.player.position.x -= game.player.speed / 60;
      break;
    case PlayerDirection.Right:
      game.player.position.x += game.player.speed / 60;
      break;
  }

  // Keep player within window bounds
  if game.player.position.x < 0 {
    game.player.position.x = 0;
  } else if game.player.position.x > 800 {
    game.player.position.x = 800;
  }
  
  if game.player.position.y < 0 {
    game.player.position.y = 0;
  } else if game.player.position.y > 600 {
    game.player.position.y = 600;
  }
}

draw_grid :: proc()
{
  for x := 20; x <= 780; x += 20 {
    rl.DrawLineV(rl.Vector2{f32(x), 20}, rl.Vector2{f32(x), 580}, rl.GRAY);
  }
  for y := 20; y <= 580; y += 20 {
    rl.DrawLineV(rl.Vector2{20, f32(y)}, rl.Vector2{780, f32(y)}, rl.GRAY);
  }
}

GameState :: struct {
  runState: RunState,
  player: PlayerState,
}

PlayerState :: struct {
  position: rl.Vector2,
  direction: PlayerDirection,
  speed: f32,
}

RunState :: enum {
  Running,
  Paused,
  Stopped,
}

PlayerDirection :: enum {
  Up,
  Down,
  Left,
  Right,
}

draw_player :: proc(player: ^PlayerState)
{
  rl.DrawCircleV(player.position, 4, rl.BLUE);
}

main :: proc()
{
  rl.InitWindow(800, 600, "Odin Raylib Tron");
  defer rl.CloseWindow();

  game := GameState{
    runState = RunState.Stopped,
    player = PlayerState{
      position = rl.Vector2{400, 300},
      direction = PlayerDirection.Right,
      speed = 100.0,
    },
  };

  rl.SetTargetFPS(60);
  
  for !rl.WindowShouldClose() {
    poll_input(&game);
    update_player(&game);
    rl.BeginDrawing();
    rl.ClearBackground(rl.BLACK);
    draw_grid();
    draw_player(&game.player);
    rl.EndDrawing();
  }
}