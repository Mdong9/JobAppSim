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

local total_money = 100000
local dtotal = 0

local main_game_screen = true
local upgrade_tree_screen = false

local exitX1
local exitX2
local exitY1
local exitY2

local exit = require("exit")
local upgrades = require("upgradeMenu")
local upgradeTree = require("upgradeTree")
local clickCheck = require("clickChecker")

local upgrade_info

local jobX1
local jobY1
local jobX2
local jobY2

local firstClick = true--used for making sure that tree upgrade click check doesnt check upgrades on click on for the tab

local jobImage
local jobWidth
local jobHeight

local jobScaleX = 0.55
local jobScaleY = 0.55
----------------------------------------------------------------------------------------
----------------------------Upgrade Buttons Initialization------------------------------
----------------------------------------------------------------------------------------
local upgradeBoxHeight = 50
local upgradeBoxWidth = 150

local virtualWindowWidth = 1920
local virtualWindowHeight = 1080

local scaleX
local scaleY
local scale = 1

local offsetX = 0
local offsetY = 0

local bgX
local bgWidth

local windowHeight = virtualWindowHeight
----------------------------------------------------------------------------------------
----------------------------Upgrade Tree Initial Values---------------------------------
----------------------------------------------------------------------------------------
local trimmedWindowWidth

----------------------------------------------------------------------------------------
----------------------------Main application functions----------------------------------
----------------------------------------------------------------------------------------
function love.load()
    -- upgrades.initializeUpgradeValues(upgradeBoxWidth, upgradeBoxHeight)
    -- upgrade_info = upgrades.info
    upgrade_info = upgrades.initializeUpgradeValues(upgradeBoxWidth, upgradeBoxHeight)
    
    love.window.setMode(1920, 1080, {
        fullscreen = false,
        resizable = false,
        }
    ) --should work
    
    trimmedWindowWidth = virtualWindowWidth*0.8
    -- scrollBarX = trimmedWindowWidth - 20
    bgX = virtualWindowWidth*0.8
    bgWidth = virtualWindowWidth - bgX

    jobImage = love.graphics.newImage("assets/Job-Application_blank_page-0001.jpg")
    jobWidth = (jobImage:getWidth()) *jobScaleX
    jobHeight = (jobImage:getHeight()) *jobScaleY

    jobX1 = (trimmedWindowWidth - jobWidth) / 2
    jobY1 = (virtualWindowHeight - jobHeight) / 2
    jobX2 = jobX1 + jobWidth
    jobY2 = jobY1 + jobHeight

    -- Set the default filter to "nearest" for pixel-perfect scaling
    love.graphics.setDefaultFilter("nearest", "nearest") 
    -- Set a background color
    love.graphics.setBackgroundColor(0.7, 0.7, 0.7)

    -- Set new cursor to new pen image
    -- penCursor = love.mouse.newCursor("penmed2.png",0,0)
    -- love.mouse.setCursor(penCursor)
end


function love.update(dt)
    upgrade_info = upgrades.updateMultiplier()
    upgrade_info = upgrades.updateMax()
    dtotal = dtotal + dt

    if dtotal > 1 then

        dtotal = dtotal - 1

        for _, upgrade in ipairs(upgrade_info) do
           total_money = total_money + (upgrade.rate * upgrade.boughtQuantity * upgrade.multiplier)
        end
    end
end


function love.draw()
    love.graphics.push()
    -- love.graphics.translate(offsetX / scale, offsetY / scale)
    -- love.graphics.scale(scale, scale)

    upgrades.drawUpgradeMenu(bgX, bgWidth, virtualWindowWidth, virtualWindowHeight, upgradeBoxHeight, upgradeBoxWidth)

    exit.drawExit(bgX, bgWidth, virtualWindowHeight, upgradeBoxHeight)
    exitX1 = exit.coords.exitX1
    exitY1 = exit.coords.exitY1
    exitX2 = exit.coords.exitX2
    exitY2 = exit.coords.exitY2

    if main_game_screen then
        love.graphics.draw(jobImage, jobX1, jobY1, 0, jobScaleX, jobScaleY)
    elseif upgrade_tree_screen then
        upgradeTree.drawTree(trimmedWindowWidth, virtualWindowHeight)
        upgradeTree.drawScrollBar(trimmedWindowWidth)
    end

    -- Counter for total_money
    love.graphics.setColor(0,0,0)
    local moneyTextHeight = font:getHeight()
    local moneyTextWidth = font:getWidth("Job Applications: " .. tostring(total_money))

    local moneyY = virtualWindowHeight*0.03 - moneyTextHeight/2
    local moneyX = virtualWindowWidth*0.8 - moneyTextWidth
    love.graphics.print("Job Applications: " .. total_money, moneyX, moneyY)
    love.graphics.setColor(1,1,1)
    
    love.graphics.pop()
end


function love.resize(w, h)
    -- realWindowHeight = h
    -- realWindowWidth = w

    scaleX = w / virtualWindowWidth
    scaleY = h / virtualWindowHeight
    scale = math.min(scaleX, scaleY)

    offsetX = (w - virtualWindowWidth  * scale) / 2
    offsetY = (h - virtualWindowHeight * scale) / 2
    -- trimmedWindowWidth = windowWidth * 0.8
    -- scrollBarX = trimmedWindowWidth - 20
    -- scrollBarOffsetMax = windowHeight - scrollBarHeight - windowHeight*0.06

    -- bgX = windowWidth*0.8
    -- bgWidth = windowWidth - bgX
end


function love.mousepressed( x, y, _, _, _)
    total_money = clickCheck.clickUpgradeCheck(x, y, upgrade_info, total_money)
    clickCheck.clickTreeTabCheck(x, y, upgrades.TabX1, upgrades.TabY1, upgrades.TabX2, upgrades.TabY2, main_game_screen, upgrade_tree_screen)
    exit.exitCheck(x, y, exitX1, exitY1, exitX2, exitY2)

    
    
    main_game_screen = clickCheck.main_game_screen
    upgrade_tree_screen = clickCheck.upgrade_tree_screen


    if main_game_screen then
        total_money = clickCheck.clickJobCheck(x,y, jobX1, jobY1, jobX2, jobY2, total_money)
        firstClick = true
    elseif upgrade_tree_screen then
        if firstClick then
            firstClick = false
        else
            total_money = upgradeTree.checkClick(x, y, total_money)
        end
        
    end
end

function love.wheelmoved(_, y)
    if upgrade_tree_screen then
        upgradeTree.updateScroll(y)
    end
end

--Things to fix or implement next
--resizeing aspect ratio preserved (Hard)
--reformat job application and upgrade shop
--add exit graphic
--add job application png
--separate functions out

