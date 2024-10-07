require("lib/luadc")
require("player")
require("map")
require("status")
require("menu")

player.load()
map.load()
menu.load()

function luadc.update() -- Required method to call updates
    if exemple.status == 0 then
        menu.update()
    elseif exemple.status == 1 then
        player.update()
    end
end

function luadc.draw() -- Required method to call draws with luadc
    if exemple.status == 0 then
        menu.draw()
        luadc.draw_menu('main') -- Write menu at the middle of the screen
    elseif exemple.status == 1 then
        map.draw() 
        player.draw() 
    end
end

local function err(e)
    curses.endwin()
    print(debug.traceback(e, 2))
    os.exit(2)
end

xpcall(luadc.init, err)