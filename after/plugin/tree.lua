local nvim_tree = require("nvim-tree")
local tree_api = require("nvim-tree.api")
-- disable netrw at the very start of your init.lua
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.keymap.set("n", "<leader>v", function()
	tree_api.tree.toggle(true,false, vim.fn.expand("%:p"))
end)

local function GetPath(node)
	local parent = node.parent
	local path = ""
	while (parent ~= nil) do
		if (path ~= "") then
			path = "/" .. path
		end
		path = node.name .. path
		node = parent
		parent = parent.parent
	end
	return path
end

vim.keymap.set("n", "vg", function()
	vim.cmd("silent !git add " .. GetPath(tree_api.tree.get_node_under_cursor()))
end)

vim.keymap.set("n", "vv", function()
	tree_api.git.reload()
end)

vim.keymap.set("n", "vr", function()
	vim.cmd("silent !git reset " .. GetPath(tree_api.tree.get_node_under_cursor()))
end)
nvim_tree.setup {}
