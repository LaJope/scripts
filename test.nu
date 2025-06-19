#!/usr/bin/env nu

let variants = [
[type, help];
[hello, why]
]

let a = [
[type, help];
[why, hello]
]

print ($variants | append $a)
