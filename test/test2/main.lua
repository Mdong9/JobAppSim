-- Job application idle game
    --application stack sprite
        --application pixel art
    --upgrade menu
        --stamps
        --autoclicker
        --autofill
        --chatgpt(knockoff)
        --clones
        --time travel machine
        --multiverse portal
    --upgrade tree menu
        --increase speed of upgrades
        --increase amount you can buy
        --referral = double gain
        --ultimate nepotism = triple gain
    --settings
        --sound
            --general
            --music
            --effects
            --reset progress
            --redeem secret code for job guarentee

--basics
    --text placements
    --text update
    --square texture change
    --clickable surfaces
    --screen menu change when hitting a button
    --borders

--love.update(dt) for when game is running every moment
--love.load() initial bootup
--love.draw() visual



local val = 0;
local borderX = 0.75 * love.graphics.getWidth()
local rightScreen = love.graphics.getWidth()
function love.update(dt)
    -- We will increase the variable by 1 for every second the key is held down.
    if love.keyboard.isDown("up") then
        val = val + dt
        print(val)
        -- print("up")
    end

    -- We will decrease the variable by 1/s if any of the wasd keys is pressed. 
    if love.keyboard.isDown('w', 'a', 's', 'd') then
        val = val - dt
        print(val)
    end

    if love.mouse.isDown(1) then
        print("left click")
    end

end

function love.load()
    -- Set the default filter to "nearest" for pixel-perfect scaling
    love.graphics.setDefaultFilter("nearest", "nearest") 
    -- Set a background color
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)

    -- Set new cursor to new pen image
    penCursor = love.mouse.newCursor("penmed2.png",0,0)
    love.mouse.setCursor(penCursor)


    
end

function love.draw()
    -- Draw a filled pixelated rectangle
    -- Arguments: mode, x, y, width, height
    love.graphics.setColor(1, 0, 1, 1)
    love.graphics.rectangle("fill", 125, 125, 50, 50)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle("fill", 137, 137, 25, 25) 
    
    -- Draw a line-based pixelated rectangle (outline)
    love.graphics.rectangle("line", 100, 100, 100, 100)

    love.graphics.printf( "hello world", 200, 200, 500, "left")

    love.graphics.line(borderX,0, borderX, 800)
    love.graphics.line(borderX, 50, rightScreen, 50)

    love.graphics.rectangle("line", 300, 100, 100, 100, 25, 25)
    
end

function love.mousemoved(x, y, dx, dy, istouch)
    if x > borderX then
        love.mouse.setVisible(false)
    end

    if x < borderX then
        love.mouse.setVisible(true)
    end
end

function love.resize(w, h)
    borderX = 0.75 * w
    rightScreen = w
end