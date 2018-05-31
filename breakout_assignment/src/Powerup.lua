--[[
    Breakout Remake

    -- Powerup Class --

    Represents a powerup which will spawn in a random location on a random timer or 
    when the score is divisible by 7 or something
]]

Powerup = Class{}

function Powerup:init(skin)
    -- simple positional and dimensional variables
    self.width = 16 
    self.height = 16 

    -- randomize starting location
    self.x = math.random(1, VIRTUAL_WIDTH - 16)
    self.y = VIRTUAL_HEIGHT / 2
    -- these variables are for keeping track of our velocity on both the
    -- X and Y axis, since the powerup can move in two dimensions
    self.dy = 10
    self.dx = 0

    -- this will effectively be the color of our powerup, and we will index
    -- our table of Quads relating to the global block texture using this
    self.skin = skin
end

--[[
    Expects an argument with a bounding box
    and returns true if the bounding boxes of this and the argument overlap.
]]
function Powerup:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function Powerup:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    -- allow powerup to bounce off walls
    if self.x <= 0 then
        self.x = 0
        self.dx = 0 
    end

    if self.x >= VIRTUAL_WIDTH - 16 then
        self.x = VIRTUAL_WIDTH - 16 
        self.dx = 0 
    end

    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
    end
end

function Powerup:render()
    -- gTexture is our global texture for all blocks
    -- gPowerupFrames is a table of quads mapping to each individual powerup skin in the texture
    love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin],
        self.x, self.y)
end
