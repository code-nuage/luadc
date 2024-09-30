# 🪨 luadc
## What is luadc?
`luadc` is a ✨ wonderful ✨ Lua library that allows you to create retro styled dungeon in the terminal.

- luadc allows you to draw interactive things to the screen, using the magic of `curses`
- It can manages collisions between these interactive things
- It also manages text and user interfaces

`luadc` is a good choice if you want:
- Easy to use terminal library
- Retro-stylish (although revamped) dungeon crawler games
- Simple collisions detection

`luadc` is a bad choice if you want:
- 2D detailed graphics (use LÖVE https://love2d.org/ instead)
- Detailed aligned rectangle collisions (use bump.lua https://github.com/kikito/bump.lua instead)
- A way to create interactives **menus** (just use `curses` by default)

## How to install luadc?
`luadc` is an easy to use terminal library, it rebinds `curses` methods but also add more features to it, in basic Lua.

First of all install `lua-rocks` via your operating system (https://luarocks.org/#quick-start).
Then install `lcurses` from `lua-rocks` with `lua-rocks install lcurses`.

After that, you just have to require it in your main code.

```lua
require("luadc")
```

## How to use luadc ?
`luadc` uses an update-draw loop that you have to intitialize in your main file.

You can check for inputs by using `luadc.input(<input>, input)`.

You can draw squares at the screen by using `luadc.draw_block` giving it to the `luadc.draw` function.
```lua
require("luadc")
player = {
  x, y = 0, 0,
}


luadc.update()
  if luadc.input("a", input) then
    player.x = player.x - 1
  else if luadc.input("d", input) then
    player.x = player.x + 1
  end
end

luadc.draw()
  luadc.draw_block("fill", "O", player.x, player.y)
end

luadc.init()
```
