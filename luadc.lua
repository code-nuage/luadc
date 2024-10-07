--[[

Author: Eloi Nuage Hariot

MIT LICENSE
Copyright (c) 2024 Eloi Nuage Hariot

]]

local curses = require('curses')
require('math')
os.setlocale("C.UTF-8")

luadc = {}

-- ===========
-- = Private =
-- ===========

-- Values

local tiles = {"█", "▓", "▒", "░"} -- Tiles with grease to draw
local map = {} -- Map that stores blocks added with luadc.add_block()
local menus = {} 

-- Interfaces

local draw = function(mode, submode, x, y, sx, sy)
    local sx, sy = sx or 1, sy or 1
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

-- =====================
-- = Public interfaces =
-- =====================

-- Values

luadc.debug = false

-- Init and close luadc

function luadc.init()
    screen = curses.initscr() -- Setting up a screen to interact with
    
    luadc.WINDOW_H, luadc.WINDOW_W = screen:getmaxyx()

    curses.cbreak()
    curses.echo(false)
    curses.nl(false)
    curses.curs_set(0)

    while true do
        luadc.draw()
        screen:refresh()

        input = screen:getch()
        
        luadc.update()
        screen:clear()
    end
end

-- Curses rebind

function luadc.input(listener, input)
    if input < 256 then input = string.char(input) end -- Translate the 256 first ASCII character to single string character

    if input == listener then -- Listen to an input to put in condition
        return true
    end
end

-- Map management

function luadc.draw_block(mode, submode, x, y, sx, sy)
    draw(mode, submode, x - 1, y - 1, sx, sy)
end

function luadc.add_block(x, y)
    if map[y] == nil then
        map[y] = {}
    end
    table.insert(map[y], x, 1)
end

function luadc.remove_block(x, y)
    table.remove(map[y], x - 1)
end

function luadc.check(x, y)
    if x >= 1 and y >= 1 and x <= luadc.WINDOW_W and y <= luadc.WINDOW_H then
        if map[y] == nil or map[y][x] ~= 1 then
            return true
        end
    end
end

function luadc.draw_collisions()
    for y = 1, #map do
        for x = 1, #map[y] do
            luadc.draw("fill", "0", x, y, 1, 1)
        end
    end
end

-- Menu management
function luadc.add_menu(name, table, func)
    menus[name] = {
        status = false,
        selector = 1,
        texts = table,
        functions = func
    }
end

function luadc.move_menu(menu, direction) 
    if direction == 'down' then
        if menus[menu].selector < #menus[menu].texts then
            menus[menu].selector = menus[menu].selector + 1
        end
    elseif direction == 'up' then
        if menus[menu].selector > 1 then
            menus[menu].selector = menus[menu].selector - 1
        end
    end
end

function luadc.execute_menu(menu)
    menus[menu].functions[menus[menu].selector]()
end

function luadc.draw_menu(menu)
    local max_size = 0

    for k, v in ipairs(menus[menu].texts) do
        if max_size < string.len(v) then
            max_size = string.len(v)
        end
    end

    local x = math.floor(luadc.WINDOW_W / 2) - math.floor(max_size / 2)
    local y = math.floor(luadc.WINDOW_H / 2) - math.floor((#menus[menu].texts * 2 - 1) / 2)

    local selector_x = x - 2
    local selector_y = y + 2 * (menus[menu].selector - 1)

    screen:mvaddstr(selector_y, selector_x, ">")

    for k, v in ipairs(menus[menu].texts) do
        screen:mvaddstr(y + k * 2 - 2, x, menus[menu].texts[k])
    end
end

return luadc