local Game = require("game")

function love.load()
	Game:load()
end

function love.update()
	Game:update()
end

function love.draw()
	Game:draw()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "r" then
		Game:reset()
	elseif key == "c" then
		Game:clear()
	end
end
