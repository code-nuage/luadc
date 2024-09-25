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
    elseif mode == "draw" then
        for col = 1, sy do
            for row = 1, sx do
                screen:mvaddstr(y + col, x + row, submode) -- Draw specific character to the screen
            end
        end
    end
end

-- =====================
-- = Public interfaces =
-- =====================

-- Curses rebind

function luadc.load()

    curses.cbreak()
    curses.echo(false)
    curses.nl(false)
    curses.curs_set(0)
    
    screen = curses.initscr() -- Setting up a screen to interact with
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


return luadc