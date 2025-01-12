--[[
    GD50 2018
    Pong Remake
    -- Paddle Class --
    Author: Colton Ogden
    cogden@cs50.harvard.edu
    Represents a paddle that can move up and down. Used in the main
    program to deflect the ball back toward the opponent.
]]

Background = Class{}

--[[
    The `init` function on our class is called just once, when the object
    is first created. Used to set up all variables in the class and get it
    ready for use.
    Our Paddle should take an X and a Y, for positioning, as well as a width
    and height for its dimensions.
    Note that `self` is a reference to *this* object, whichever object is
    instantiated at the time this function is called. Different objects can
    have their own x, y, width, and height values, thus serving as containers
    for data. In this sense, they're very similar to structs in C.
]]
function Background:init(x, y, width, height)
    self.x = x
    self.y = y
    self.img = love.graphics.newImage("assets/korone.JPG")
    self.width = width
    self.height = height
    self.dy = 0
end


--[[
    To be called by our main function in `love.draw`, ideally. Uses
    LÖVE2D's `rectangle` function, which takes in a draw mode as the first
    argument as well as the position and dimensions for the rectangle. To
    change the color, one must call `love.graphics.setColor`. As of the
    newest version of LÖVE2D, you can even draw rounded rectangles!
]]
function Background:render()
    love.graphics.draw(self.img,self.x,self.y)
end
