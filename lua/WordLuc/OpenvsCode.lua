local function openVs(path, nLess)
	local segments = {}
<<<<<<< HEAD
	if path == '""' or nLess == -1 then
		vim.cmd("! code -r .")
		return;
	end
=======
>>>>>>> parent of 51dd442 (feat: fix open vscode)
	for segment in path:gmatch("[^/|\\]+") do
		table.insert(segments, segment)
	end
	local newPath = table.concat(segments, "/", 1, #segments - nLess)
	vim.cmd("!code -r " .. newPath .. '"')
end

vim.keymap.set("n", ":vs", function()
	local path = vim.fn.shellescape(vim.fn.expand("%:p"))
	if path == '""' then
		vim.cmd("! code -r .")
		return;
	end
	openVs(path, 1)
end)

vim.keymap.set("n", ":vs-", function()
	local path = vim.fn.shellescape(vim.fn.expand("%:p"))
	if path == '""' then
		vim.cmd("! code -r .")
		return;
	end
	openVs(path, 2)
end)

<<<<<<< HEAD
vim.keymap.set("n", ":vsr", function()
	openVs(nil, -1)
end)
=======
>>>>>>> parent of 51dd442 (feat: fix open vscode)
