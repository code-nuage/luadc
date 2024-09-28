--[[




]]

local curses = require('curses')
os.setlocale("C.UTF-8")

luadc = {}

-- ===========
-- = Private =
-- ===========

-- Values

local tiles = {"█", "▓", "▒", "░"} -- Tiles with grease to draw

-- Interfaces

local draw = function(mode, submode, x, y, sx, sy)
    if mode == "tiles" then
        for col = 1, sy do
            for row = 1, sx do
                screen:mvaddstr(y + col - 1, x + row - 1, tiles[submode]) -- Draw tile with grease to the screen
            end
        end
    elseif mode == "fill" then
        for col = 1, sy do
            for row = 1, sx do
                screen:mvaddstr(y + col - 1, x + row - 1, submode) -- Draw specific character to the screen
            end
        end
    end
end

local map = {}

-- =====================
-- = Public interfaces =
-- =====================

-- Curses rebind

function luadc.load()
    screen = curses.initscr() -- Setting up a screen to interact with

    curses.cbreak()
    curses.echo(false)
    curses.nl(false)
    curses.curs_set(0)
end

function luadc.clear()
    screen:clear()
end

function luadc.input(input, listener)
    if input < 256 then input = string.char(input) end -- Translate the 256 first ASCII character to single string character

    if input == listener then -- Listen to an input to put in condition
        return true
    end
end

function luadc.draw(mode, submode, x, y, sx, sy)
    draw(mode, submode, x, y, sx, sy)
end

-- Collisions management
function luadc.add_block(x, y)
    if map[y] == nil then
        map[y] = {}
    end
    table.insert(map[y], x, 1)
end

function luadc.remove_block(x, y)
    table.remove(map[y - 1], x - 1)
end

function luadc.check(x, y)
    if map[y][x] ~= 1 then
        return true
    end
end

function luadc.draw_collisions()
    for y = 1, #map do
        for x = 1, #map[y] do
            luadc.draw("fill", "0", x, y, 1, 1)
        end
    end
end

-- Text management
function luadc.text()

end

return luadc