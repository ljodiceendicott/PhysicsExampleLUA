-- physicshelper.lua
-- DOCS:
-- usage:
--   require("physicshelper")
--   makePlatform(..)
--   makeObject(..)


function makeObject(objectType, col, row, bodyType,img)
    local tbl = {}

    local x = ((col-1) * globals.TILESIZE) + globals.HALFTILESIZE
    local y = ((row-1) * globals.TILESIZE) + globals.HALFTILESIZE
    tbl.img = img
    tbl.body = love.physics.newBody(world, x, y, bodyType) --x,y
    tbl.shape = love.physics.newRectangleShape(globals.TILESIZE, globals.TILESIZE) --w,h
    -- attach shape to body
    tbl.fixture = love.physics.newFixture(tbl.body, tbl.shape)
    tbl.fixture:setUserData(objectType)

    function tbl.draw()
      love.graphics.setColor({1,1,1})
      local tbl_x, tbl_y = tbl.body:getPosition()
      love.graphics.draw(tbl.img,tbl_x, tbl_y,tbl.body:getAngle(),1,1,16,16)
    end
    return tbl
end

function makePlatform(col, row, color, img)
    local tmp = {}

    tmp = makeObject("platform", col, row, "static")
    tmp.color = color
    tmp.img = img

    function tmp.draw()
        love.graphics.setColor(tmp.color)

        -- draw a "filled in" polygon using the platform's coordinates
       -- love.graphics.polygon("fill", tmp.body:getWorldPoints(
       --                          tmp.shape:getPoints()))
       local tmp_x, tmp_y = tmp.body:getPosition()
       love.graphics.draw(tmp.img,tmp_x, tmp_y-16)

        -- love.graphics.draw(img,tmp.body:getWorldPoints())
    end

    return tmp
end
