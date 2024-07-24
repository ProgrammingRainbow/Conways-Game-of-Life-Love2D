local CELL = 10
local SIZE = CELL - 1
local WIDTH = love.graphics.getWidth()
local HEIGHT = love.graphics.getHeight()

local Game = {
	_rows = math.floor(HEIGHT / CELL),
	_columns = math.floor(WIDTH / CELL),
	_board = {},
	_next_board = {},
	_delay_target = 8,
	_delay_count = 1,
}

function Game:load()
	math.randomseed(os.time())

	-- Create 2D table for board.
	for row = 1, self._rows do
		self._board[row] = {}
		self._next_board[row] = {}
		for column = 1, self._columns do
			self._board[row][column] = 0
			self._next_board[row][column] = 0
		end
	end

	self:reset()
end

function Game:reset()
	for row, columns in ipairs(self._board) do
		for column, _ in ipairs(columns) do
			self._board[row][column] = love.math.random(0, 1)
		end
	end
end

function Game:clear()
	for row, columns in ipairs(self._board) do
		for column, _ in ipairs(columns) do
			self._board[row][column] = 0
		end
	end
end

function Game:update()
	if self._delay_count >= self._delay_target then
		for row, columns in ipairs(self._board) do
			for column, value in ipairs(columns) do
				local count = 0
				for y = row - 1, row + 1 do
					for x = column - 1, column + 1 do
						if not (row == y and column == x) then
							local wrapped_row = ((y - 1) % self._rows) + 1
							local wrapped_column = ((x - 1) % self._columns) + 1
							count = count + self._board[wrapped_row][wrapped_column]
						end
					end
				end
				if value == 1 and count > 1 and count < 4 then
					self._next_board[row][column] = 1
				elseif value == 0 and count == 3 then
					self._next_board[row][column] = 1
				else
					self._next_board[row][column] = 0
				end
			end
		end
		local temp = self._board
		self._board = self._next_board
		self._next_board = temp

		self._delay_count = 1
	else
		self._delay_count = self._delay_count + 1
	end
end

function Game:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)

	love.graphics.setColor(0.5, 0.5, 0.5)

	for row, columns in ipairs(self._board) do
		for column, value in ipairs(columns) do
			if value == 1 then
				local x = (column - 1) * CELL
				local y = (row - 1) * CELL
				love.graphics.rectangle("fill", x, y, SIZE, SIZE)
			end
		end
	end
end

return Game
