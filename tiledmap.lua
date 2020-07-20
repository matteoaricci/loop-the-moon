function loadTiledMap(path)
    local map = require(path)

    map.quads = {}
    local tileset = map.tilesets[1]
    map.tileset = tileset
    map.image = love.graphics.newImage('/images/'..tileset.image)

    love.graphics.print(tileset.imageheight, 200, 100)

    for y = 0, (tileset.imageheight / tileset.tileheight) - 1 do 
        for x = 0, (tileset.imagewidth / tileset.tilewidth) - 1 do 
            local quad = love.graphics.newQuad(
                x * tileset.tilewidth,
                y * tileset.tileheight,
                tileset.tilewidth,
                tileset.tileheight,
                tileset.imagewidth,
                tileset.imageheight
            )
            table.insert(map.quads, quad)
        end
    end

    
function map:pointToTile(x, y)
    if x < 0 or x > self.width * TILE_SIZE or y < 0 or y > self.height * TILE_SIZE then 
        return nil 
    end

    return self.quads[math.floor(y / TILE_SIZE) + 1][math.floor(x / TILE_SIZE) + 1]
end

    function map:draw()
        for i, layer in ipairs(self.layers) do 
            for y = 0, layer.height - 1 do 
                for x = 0, layer.width - 1 do
                    local index = (x + y * layer.width) + 1
                    local tid = layer.data[index] 

                    if tid ~= 0 then
                        local quad = self.quads[tid]
                        local xx = x * self.tileset.tilewidth
                        local yy = y * self.tileset.tileheight

                        love.graphics.draw(
                            self.image,
                            quad, 
                            xx,
                            yy
                        )
                    end
                end
            end
        end
    end
    return map
end
