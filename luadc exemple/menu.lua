menu = {
    title = {
        " _                 _      ",
        "| |_   _  __ _  __| | ___ ",
        "| | | | |/ _` |/ _` |/ __|",
        "| | |_| | (_| | (_| | (__ ",
        "|_|\\__,_|\\__,_|\\__,_|\\___|",
        "Proof of concept of luadc"
    },

    load = function()
        luadc.add_menu('main', {"Play", "Options", "Quit"}, {exemple.play, menu.options, menu.quit})
    end,

    update = function()
        if luadc.input("w", input) then
            luadc.move_menu('main', 'up')
        end
        if luadc.input("s", input) then
            luadc.move_menu('main', 'down')
        end
        if luadc.input(" ", input) then
            luadc.execute_menu('main')
        end
    end,

    draw = function()
        for i = 1, #menu.title do
            luadc.draw_text(menu.title[i], math.floor(luadc.WINDOW_W / 2 - math.floor(string.len(menu.title[1]) / 2)), 2 + i - 1)
        end
        luadc.draw_text("w/s/space > navigate in the menu", 1, luadc.WINDOW_H - 1)
    end,

    play = function()
        exemple.status = 1
    end,

    options = function()

    end,

    quit = function()
        os.exit()
    end
}