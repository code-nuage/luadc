menu = {
    title = {
        " _                 _      ",
        "| |_   _  __ _  __| | ___ ",
        "| | | | |/ _` |/ _` |/ __|",
        "| | |_| | (_| | (_| | (__ ",
        "|_|\\__,_|\\__,_|\\__,_|\\___|",
        "Proof of concept of luadc"
    },

    main = {
        draw = function()
            for i = 1, #menu.title do
                luadc.draw_text(menu.title[i], math.floor(luadc.WINDOW_W / 2 - math.floor(string.len(menu.title[1]) / 2)), 2 + i - 1)
            end
            luadc.draw_text(player.controls.up .. "/" .. player.controls.down .. "/space > navigate in the menu", 1, luadc.WINDOW_H - 1)
        end,

        play = function()
            exemple.status = 1
        end,

        options = function()
            menu.current = 'options'
        end,

        quit = function()
            os.exit()
        end
    },

    options = {
        draw = function()
            --[[for i = 1, #menu.title do
                luadc.draw_text(menu.title[i], math.floor(luadc.WINDOW_W / 2 - math.floor(string.len(menu.title[1]) / 2)), 2 + i - 1)
            end]]
        end,

        controls = function()
            menu.current = 'controls';
        end,

        back = function()
            menu.current = 'main'
        end
    },

    controls = {
        draw = function()

        end,

        edit = 'up',

        test = function(action)
            menu.current = 'edit_controls'
            menu.controls.edit = action
        end,

        back = function()
            menu.current = 'options'
        end
    },

    edit_controls = {
        draw = function()
            luadc.draw_text("Trigger a key to bind it to [" .. menu.controls.edit .. "]", math.floor(luadc.WINDOW_W / 2) - math.floor(string.len("Trigger a key to bind it to [" .. menu.controls.edit .. "]") / 2), math.floor(luadc.WINDOW_H / 2))
            luadc.draw_text("The current one is '" .. player.controls[menu.controls.edit] .. "'", math.floor(luadc.WINDOW_W / 2) - math.floor(string.len("The current one is '" .. player.controls[menu.controls.edit] .. "'") / 2), math.floor(luadc.WINDOW_H / 2) + 1)
        end,


    },

    load = function()
        menu.current = 'main'
        luadc.add_menu('main', {"Play", "Options", "Quit"}, {menu.main.play, menu.main.options, menu.main.quit})
        luadc.add_menu('options', {"Controls", "Back"}, {menu.options.controls, menu.options.back})
        luadc.add_menu('controls', {"Up", "Down", "Left", "Right", "Attack", "Back"}, {
            function() menu.controls.test('up') end,
            function() menu.controls.test('down') end,
            function() menu.controls.test('left') end,
            function() menu.controls.test('right') end,
            function() menu.controls.test('attack') end,
            function() menu.controls.back() end
        })
        luadc.add_menu('edit_control', {}, {})
    end,

    draw = function()
        menu[menu.current].draw(menu.current)
        if menu.current ~= 'edit_controls' then
            luadc.draw_menu(menu.current)
        end
    end,

    update = function()
        if menu.current ~= 'edit_controls' then
            if luadc.input(player.controls.up, input) then
                luadc.move_menu(menu.current, 'up')
            end
            if luadc.input(player.controls.down, input) then
                luadc.move_menu(menu.current, 'down')
            end
            if luadc.input(player.controls.confirm, input) then
                luadc.execute_menu(menu.current)
            end
        end

        if menu.current == 'edit_controls' then
            if input ~= nil then
                if input < 256 then input = string.char(input) end
                if input ~= ' ' then
                    player.controls[menu.controls.edit] = input
                    menu.current = 'controls'
                end
            end
        end
    end,
}