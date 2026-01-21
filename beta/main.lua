-- rinkimirikakuta temotoji
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
        --end game (saves state of game right before pressing it, also quits game by itself, plays video of me thanking them for playing my first game and for encouraging me to do so)
    --upgrade tree menu
        --unlock upgrade status
        --increase speed of upgrades
        --increase amount you can buy
        --referral = double gain
        --ultimate nepotism = triple gain
        --IDEAS details: (total number of tree nodes: 6 + 21 + 7 + 7 + 7 + 1)
            --unlock upgrades 2,3,4,5,6,7
            --3 max amount increase upgrades for all upgrades
            --1 speed increase for all upgrades
            --double gain for all upgrades
            --triple gain for all upgrades
            --end the game purchase unlock
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

--REMEMBER TO ADD unlockStatus FLAG
--CLEAN CODE UP
local font = love.graphics.getFont()

local total_money = 0
local dtotal = 0

local main_game_screen = true
local upgrade_tree_screen = false

local exitX1
local exitX2
local exitY1
local exitY2

local scroll = 0

local exit = require("exit")
local upgrades = require("upgradeMenu")
local upgradeTree = require("upgradeTree")

local upgrade_info
----------------------------------------------------------------------------------------
----------------------------Upgrade Buttons Initialization------------------------------
----------------------------------------------------------------------------------------
local upgradeBoxHeight = 50
local upgradeBoxWidth = 150

local windowWidth = 1280
local windowHeight = 720

local bgX
local bgWidth
----------------------------------------------------------------------------------------
----------------------------Upgrade Tree Initial Values---------------------------------
----------------------------------------------------------------------------------------
local trimmedWindowWidth = windowWidth * 0.8

local scrollBarOffset = 0
local scrollBarX = trimmedWindowWidth - 20
local scrollBarHeight = 150
local scrollBarWidth = 20
local scrollBarOffsetMin = 0
local scrollBarOffsetMax = windowHeight - scrollBarHeight - windowHeight*0.06

function checkDependency(curr_upgrade)
    for _, tier in ipairs(tree_upgrade_tiers) do
        for _, upgrade in ipairs(tier) do
            if upgrade.name == curr_upgrade.dependency and upgrade.unlockStatus == true then
                curr_upgrade.unlockStatus = true
                return curr_upgrade.unlockStatus
            end
        end
    end
end

function checkEndgame()
    local endgameFlag = false
    for tier = 1, 4 do
        for _, upgrade in ipairs(tree_upgrade_tiers[tier]) do
            if upgrade.unlockStatus == false and upgrade.name ~= "endgame" then
                endgameFlag = false
                break
            end
        end
    end

    if endgameFlag then
        tree_upgrade_tiers[5][1].unlockStatus = true
    end
end


function drawLine(node1, node2)
    love.graphics.line(node1.x2/2, node1.y2/2, node2.x2/2, node2.y2/2)
end

function drawUpgradeTreeScrollBar()
    love.graphics.setColor(0.45,0.45,0.45)
    love.graphics.rectangle("fill", scrollBarX, windowHeight*0.06 + scrollBarOffset, scrollBarWidth, scrollBarHeight)
    love.graphics.setColor(1,1,1)
end

----------------------------------------------------------------------------------------
----------------------------Upgrade Buttons Click Check---------------------------------
----------------------------------------------------------------------------------------
function clickUpgradeCheck(mouseX, mouseY)
    -- local mouseX, mouseY = love.mouse.getPosition( )
    -- print("Upgrade " .. "x: " .. mouseX .. " y: " .. mouseY)
    for _, button in ipairs(upgrade_info) do

        -- print(button.name .. " x1: " .. button.x1 .. " y1: " .. button.y1 .. " x2: " .. button.x2 .. " y2: " .. button.y2)
        if mouseX >= button.x1 and mouseX <= button.x2 and mouseY >= button.y1 and mouseY <= button.y2 then
            
            if button.boughtQuantity < button.maxQuantity and total_money >= button.price then
                -- print("buying upgrade")
                total_money = total_money - button.price

                button.boughtQuantity = button.boughtQuantity + 1 --update value bought
                button.price = (button.base_price * (1.20 ^ button.boughtQuantity)) + button.price
                --update upgrade related values later
                --change color of box when pressed then change it back
            end
            break
        end
    end
end
----------------------------------------------------------------------------------------
----------------------------Main clicker Click Check------------------------------------
----------------------------------------------------------------------------------------
function clickJobCheck(mouseX, mouseY)
    x1 = (windowWidth*0.8)/2 - rectangle_width/2
    y1 = windowHeight/2 - rectangle_height/2
    x2 = (windowWidth*0.8)/2 + rectangle_width/2
    y2 = windowHeight/2 + rectangle_height/2

    if mouseX > x1 and mouseX < x2 and mouseY > y1 and mouseY < y2 then
        total_money = total_money + 1
    end
end
----------------------------------------------------------------------------------------
--------------------------------Upgrade Tree Click Check--------------------------------
----------------------------------------------------------------------------------------
function clickTreeTabCheck(mouseX, mouseY)
    x1 = windowWidth*0.82
    y1 = windowHeight*0.06 - upgrades.TabHeight
    x2 = windowWidth*0.82 + upgrades.TabWidth
    y2 = windowHeight*0.06

    if mouseX > x1 and mouseX < x2 and mouseY > y1 and mouseY < y2 then
        main_game_screen = not main_game_screen
        upgrade_tree_screen = not upgrade_tree_screen
    end
end
----------------------------------------------------------------------------------------
--------------------------------Main Clicker visual-------------------------------------
----------------------------------------------------------------------------------------
function drawJobApplication()
    rectangle_height = (windowHeight*0.8) --height_pixel
    rectangle_width = (windowWidth*0.6) -- width
    love.graphics.rectangle("fill", (windowWidth*0.8)/2 - rectangle_width/2, windowHeight/2 - rectangle_height/2, rectangle_width, rectangle_height)
end
----------------------------------------------------------------------------------------
----------------------------Main application functions----------------------------------
----------------------------------------------------------------------------------------
function love.load()
    upgrades.initializeUpgradeValues(upgradeBoxWidth, upgradeBoxHeight)
    upgrade_info = upgrades.info
    
    love.window.setMode(1280, 720, {
        fullscreen = false,
        resizable = true,
        minwidth = 800,    -- minimum width
        minheight = 600    -- minimum height
        }
    ) --should work
    
    bgX = windowWidth*0.8
    bgWidth = windowWidth - bgX


    -- Set the default filter to "nearest" for pixel-perfect scaling
    love.graphics.setDefaultFilter("nearest", "nearest") 
    -- Set a background color
    love.graphics.setBackgroundColor(0.7, 0.7, 0.7)

    -- Set new cursor to new pen image
    -- penCursor = love.mouse.newCursor("penmed2.png",0,0)
    -- love.mouse.setCursor(penCursor)
end

function love.update(dt)
    dtotal = dtotal + dt

    if dtotal > 1 then

        dtotal = dtotal - 1

        for _, upgrade in ipairs(upgrade_info) do
           total_money = total_money + (upgrade.rate * upgrade.boughtQuantity)
        end
    end
end

function love.draw()
    upgrades.drawUpgradeMenu(bgX, bgWidth, windowWidth, windowHeight, upgradeBoxHeight, upgradeBoxWidth)

    exit.drawExit(bgX, bgWidth, windowHeight, upgradeBoxHeight)
    exitX1 = exit.coords.exitX1
    exitY1 = exit.coords.exitY1
    exitX2 = exit.coords.exitX2
    exitY2 = exit.coords.exitY2

    -- Counter for total_money
    love.graphics.setColor(0,0,0)
    local moneyTextHeight = font:getHeight()
    local moneyTextWidth = font:getWidth("Job Applications: " .. tostring(total_money))

    local moneyY = windowHeight*0.03 - moneyTextHeight/2
    local moneyX = windowWidth*0.8 - moneyTextWidth
    love.graphics.print("Job Applications: " .. total_money, moneyX, moneyY)
    love.graphics.setColor(1,1,1)
    
    if main_game_screen then
        drawJobApplication()
    elseif upgrade_tree_screen then
        upgradeTree.renderTree(trimmedWindowWidth)
        drawUpgradeTreeScrollBar()
    end
end

function love.resize(w, h)
    windowHeight = h
    windowWidth = w

    trimmedWindowWidth = windowWidth * 0.8
    scrollBarX = trimmedWindowWidth - 20
    scrollBarOffsetMax = windowHeight - scrollBarHeight - windowHeight*0.06

    bgX = windowWidth*0.8
    bgWidth = windowWidth - bgX
end

function love.mousepressed( x, y, _, _, _)
    clickUpgradeCheck(x,y)
    clickTreeTabCheck(x,y)

    exit.exitCheck(x, y, exitX1, exitY1, exitX2, exitY2)

    if main_game_screen then
        clickJobCheck(x,y)
    elseif upgrade_tree_screen then

    end
end

function love.wheelmoved(_, y)
    
    if upgrade_tree_screen then
        scrollBarOffset = scrollBarOffset - y*30
        if y > 0 then
            if scrollBarOffset < scrollBarOffsetMin then
                scrollBarOffset = 0
            end
        elseif y < 0 then
            if scrollBarOffset > scrollBarOffsetMax then
                scrollBarOffset = scrollBarOffsetMax
            end
        end
    end
end

--Things to fix or implement next
--scroll and spacer for upgrades
--resizeing aspect ratio preserved (Hard)
--reformat job application and upgrade shop
--add exit graphic
--add job application png
--separate functions out
