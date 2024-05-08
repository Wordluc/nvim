local function openVs(path, nLess)
	local segments = {}

	if path == nil or nLess == -1 then
		vim.cmd("! code -r .")
		return;
	end

	for segment in path:gmatch("[^/|\\]+") do
		table.insert(segments, segment)
	end
	local newPath = table.concat(segments, "/", 1, #segments - nLess)
	vim.cmd("!code -r " .. newPath .. '"')
end

vim.keymap.set("n", "vs", function()
	local path = vim.fn.shellescape(vim.fn.expand("%:p"))
	openVs(path, 1)
end)

vim.keymap.set("n", "vs-", function()
	local path = vim.fn.shellescape(vim.fn.expand("%:p"))
	openVs(path, 2)
end)
vim.keymap.set("n", "vso", function()
	openVs(nil, -1)
end)
