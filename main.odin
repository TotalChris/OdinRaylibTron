package main;

import "core:fmt";
import "core:math/rand";

generate_number :: proc() -> int
{
  return rand.int_range(1, 100);
}

main :: proc()
{
  fmt.println("Hello, Odin!");
  fmt.printfln("Hello, Odin! %d", generate_number());
}