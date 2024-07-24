local CELL = 9
local SIZE = CELL - 1
local WIDTH = love.graphics.getWidth()
local HEIGHT = love.graphics.getHeight()

local Game = {
	_rows = math.floor(HEIGHT / CELL),
	_columns = math.floor(WIDTH / CELL),
	_board = {},
}

function Game:load()
	-- Create 2 2D tables for boards.
	for row = 1, self._rows do
		self._board[row] = {}
		for column = 1, self._columns do
			self._board[row][column] = 0
		end
	end

	self:reset()
end

function Game:reset()
	for row, rows in ipairs(self._board) do
		for column, _ in ipairs(rows) do
			self._board[row][column] = love.math.random(0, 1)
		end
	end
end

function Game:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)

	love.graphics.setColor(0.5, 0.5, 0.5)
	for row, rows in ipairs(self._board) do
		for column, value in ipairs(rows) do
			if value == 1 then
				local x = (column - 1) * CELL
				local y = (row - 1) * CELL
				love.graphics.rectangle("fill", x, y, SIZE, SIZE)
			end
		end
	end
end

return Game
