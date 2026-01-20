local upgrades = {}

local upgradeBox

local upgradeTabWidth
local upgradeTabHeight

local font = love.graphics.getFont()
----------------------------------------------------------------------------------------
----------------------------Render Upgrades Main Screen---------------------------------
----------------------------------------------------------------------------------------
local upgrade_info = {}
local upgrade_base = {
    {name = "Stamp", description = "placeholder", unlockStatus = true, base_price = 5, maxQuantity = 10, rate = 1},
    {name = "Autoclicker", description = "placeholder", unlockStatus = false, base_price = 100, maxQuantity = 10, rate = 5},
    {name = "Autofill", description = "placeholder", unlockStatus = false, base_price = 1000, maxQuantity = 10, rate = 50},
    {name = "JobGPT", description = "placeholder", unlockStatus = false, base_price = 10000, maxQuantity = 10, rate = 250},
    {name = "Clones", description = "placeholder", unlockStatus = false, base_price = 151001, maxQuantity = 10, rate = 1000},
    {name = "Time Machine", description = "placeholder", unlockStatus = false, base_price = 101010101, maxQuantity = 10, rate = 100000},
    {name = "Multiverse", description = "placeholder", unlockStatus = false, base_price = 7777777777, maxQuantity = 10, rate = 1000000}
}

function createUpgradeBox(boxWidth, boxHeight, unlockStatus, textName, textDescription, base_price, maxQuantity, rate)
    upgradeBox = {
        width = boxWidth,
        height = boxHeight,
        unlockStatus = unlockStatus,
        name = textName,
        description = textDescription,
        base_price = base_price,
        price = base_price,
        boughtQuantity = 0,
        maxQuantity = maxQuantity,
        rate = rate,
        x1 = 0,
        x2 = 1,
        y1 = 0,
        y2 = 1,
        color = {1,1,1}
    }
    return upgradeBox
end

function upgrades.initializeUpgradeValues(upgradeBoxWidth, upgradeBoxHeight)
    for i=1,7 do
        upgradeBox = createUpgradeBox(
            upgradeBoxWidth, 
            upgradeBoxHeight, 
            upgrade_base[i].unlockStatus, 
            upgrade_base[i].name, 
            upgrade_base[i].description, 
            upgrade_base[i].base_price, 
            upgrade_base[i].maxQuantity,
            upgrade_base[i].rate
        )
        table.insert(upgrade_info, upgradeBox)
    end
end

function drawUpgradeMenuBackground(bgX, bgWidth, windowHeight)
    --color of box
    love.graphics.setColor(0.2, 0.2, 0.2)
    --box dimensions/location
    love.graphics.rectangle("fill", bgX, 0, bgWidth, windowHeight)

    love.graphics.setColor(1,1,1)
end

function drawUpgradeButtons(bgX, bgWidth, windowWidth, windowHeight, upgradeBoxHeight, upgradeBoxWidth)
    local margin = 16
    --remember to add coords to upgrade boxes for click checks
    local offset_y = 0
    for _, button in ipairs(upgrade_info) do
        love.graphics.setColor(button.color)
        -- draws upgrade box
        love.graphics.rectangle(
            "fill",
            bgX + bgWidth*0.2,
            windowHeight*0.1 + offset_y,
            bgWidth*0.6,
            upgradeBoxHeight
        )

        --update box coords
        button.x1 = bgX + bgWidth*0.2 
        button.x2 = bgX + bgWidth*0.2 + bgWidth*0.6
        button.y1 = windowHeight*0.1 + offset_y
        button.y2 = windowHeight*0.1 + offset_y + upgradeBoxHeight
        
        --set color to draw in to black
        love.graphics.setColor(0,0,0)

        --print button name
        love.graphics.print(button.name, windowWidth*0.9 - (upgradeBoxWidth/2), windowHeight*0.1 + offset_y)
        
        --print button price
        button.price = math.floor(button.price)
        love.graphics.print("$" .. button.price, windowWidth*0.9 - (upgradeBoxWidth/2), windowHeight*0.1 + offset_y + upgradeBoxHeight*0.70)

        
        local textWidth = font:getWidth(tostring(button.boughtQuantity) .. "/" .. button.maxQuantity)
        love.graphics.print(button.boughtQuantity .. "/" .. button.maxQuantity, windowWidth*0.9 + (upgradeBoxWidth/2) - textWidth, windowHeight*0.1 + offset_y + upgradeBoxHeight*0.70)

        offset_y = upgradeBoxHeight + margin + offset_y

        love.graphics.setColor(1,1,1)
    end
end

function drawUpgradeMenuTabs(windowWidth, windowHeight)
    --divider for tabs from upgrades
    love.graphics.line(windowWidth*0.8, windowHeight*0.06, windowWidth, windowHeight*0.06)

    --upgrade tree tab
    upgradeTabHeight = 20
    upgradeTabWidth = 25
    love.graphics.rectangle("fill", windowWidth*0.82, windowHeight*0.06 - upgradeTabHeight, upgradeTabWidth, upgradeTabHeight)

    upgrades.TabHeight = upgradeTabHeight
    upgrades.TabWidth = upgradeTabWidth
end

----------------------------------------------------------------------------------------
--------------------------------Initialized Upgrade Menu--------------------------------
----------------------------------------------------------------------------------------
function upgrades.drawUpgradeMenu(bgX, bgWidth, windowWidth, windowHeight, upgradeBoxHeight, upgradeBoxWidth)
    drawUpgradeMenuBackground(bgX, bgWidth, windowHeight)
    drawUpgradeMenuTabs(windowWidth, windowHeight)
    drawUpgradeButtons(bgX, bgWidth, windowWidth, windowHeight, upgradeBoxHeight, upgradeBoxWidth)
end

upgrades.info = upgrade_info

return upgrades