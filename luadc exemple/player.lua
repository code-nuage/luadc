player = {
    load = function()
        player.x, player.y = 3, 3
        player.w, player.h = 1, 1
        player.char = "⸰"
        player.health = 10
    end,

    update = function()
        if luadc.input("w", input) then
            if luadc.check(player.x, player.y - 1) then
                player.y = player.y - 1
            end
        elseif luadc.input("s", input) then
            if luadc.check(player.x, player.y + 1) then
                player.y = player.y + 1
            end
        elseif luadc.input("a", input) then
            if luadc.check(player.x - 1, player.y) then
                player.x = player.x - 1
            end
        elseif luadc.input("d", input) then
            if luadc.check(player.x + 1, player.y) then
                player.x = player.x + 1
            end
        end
    end,

    draw = function()
        luadc.draw_block("fill", player.char, player.x, player.y)
        luadc.draw_text("Health: " .. player.health, 1, luadc.WINDOW_H - 1)
    end
}