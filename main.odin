package main;

import "core:fmt";
import "core:math/rand";
import rl "vendor:raylib";

draw_grid :: proc()
{
  for x := 20; x <= 780; x += 20 {
    rl.DrawLineV(rl.Vector2{f32(x), 20}, rl.Vector2{f32(x), 580}, rl.GRAY);
  }
  for y := 20; y <= 580; y += 20 {
    rl.DrawLineV(rl.Vector2{20, f32(y)}, rl.Vector2{780, f32(y)}, rl.GRAY);
  }
}

main :: proc()
{
  rl.InitWindow(800, 600, "Odin Raylib Tron");
  defer rl.CloseWindow();

  rl.SetTargetFPS(60);
  
  for !rl.WindowShouldClose() {
    rl.BeginDrawing();
    rl.ClearBackground(rl.BLACK);
    draw_grid();
    rl.EndDrawing();
  }
}