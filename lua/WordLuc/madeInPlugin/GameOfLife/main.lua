local win = require("WordLuc.utils.window")
local parentSize = {
	x = vim.api.nvim_win_get_width(0),
	y = vim.api.nvim_win_get_height(0)
}
local childSize = {
	x = math.floor(parentSize.x * (1 - 0.20)),
	y = math.floor(parentSize.y * (1 - 0.20))
}
local childPosition = {
	y = vim.api.nvim_win_get_height(0) - childSize.y / 2 - parentSize.y / 2,
	x = vim.api.nvim_win_get_width(0) - childSize.x / 2 - parentSize.x / 2
}
local key
vim.on_key(function(v) key = v end)

local function initializeMatrix()
	local matrix = {}
	for x = 0, childSize.x - 1 do
		for y = 0, childSize.y - 1 do
			local v = math.random(0, 9) == 0
			local index = x .. ":" .. y
			matrix[index] = v
		end
	end
	return matrix
end

local function drawMatrix(matrix, buf)
	for x = 0, childSize.x - 1 do
		for y = 0, childSize.y - 1 do
			if matrix[x .. ":" .. y] == true then
				win.write_pixel(buf, x, y, "o")
			else
				win.write_pixel(buf, x, y, " ")
			end
		end
	end
end

local function getNeighbors(x, y, matrix)
	local c = 0
	for ix = x - 1, x + 1 do
		for iy = y - 1, y + 1 do
			if (x ~= ix or y ~= iy) then
				if matrix[ix .. ":" .. iy] then
					c = c + 1
				end
			end
		end
	end
	return c
end

local function isDeath(x, y, matrix)
	local c = getNeighbors(x, y, matrix)
	if c == 3 then
		matrix[x .. ":" .. y] = true
		return true
	end
	return false
end

local function isAlive(x, y, matrix)
	local c = getNeighbors(x, y, matrix)
	if c < 2 then
		matrix[x .. ":" .. y] = false
		return true
	end
	if c > 3 then
		matrix[x .. ":" .. y] = false
		return true
	end
	return false
end

local function loop(matrix, buf,time)
	if time == nil then
		time = 100
	end
	if time <= 0 then
		return
	end
	if key ~= nil then
		vim.cmd("bd " .. buf)
		return
	end
	local isChanged
	for x = 0, childSize.x - 1 do
		for y = 0, childSize.y - 1 do
			if matrix[x .. ":" .. y] == false then
				isChanged = isDeath(x, y, matrix) or isChanged
			else
				isChanged = isAlive(x, y, matrix) or isChanged
			end
		end
	end

	drawMatrix(matrix, buf)
	vim.defer_fn(function()
		if isChanged == false then
			matrix = initializeMatrix()
		end
		loop(matrix, buf)
	end, time)
end
return function(time)
	key = nil
	local r = win.open_buffer(childPosition, childSize)
	win.fill_buffer(r.buf, " ")
	loop(initializeMatrix(), r.buf)
end
