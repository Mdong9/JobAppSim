function love.load()
    button = {
        x = 100,
        y = 100,
        width = 200,
        height = 100,
        color = {0.3, 0.6, 1},
        text = "Click Me!"
    }
end

function love.draw()
    -- Draw button
    love.graphics.setColor(button.color)
    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)

    -- Draw text
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(button.text, button.x, button.y + 35, button.width, "center")
end

function love.mousepressed(mx, my, buttonKey)
    if buttonKey == 1 then -- left mouse button
        if mx > button.x and mx < button.x + button.width and
           my > button.y and my < button.y + button.height then
            print("Button clicked!")
            -- You could trigger something here, like changing color:
            button.color = {math.random(), math.random(), math.random()}
        end
    end
end
