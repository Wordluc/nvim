vim.g.mapleader = " "
vim.keymap.set("n", "<leader>z", function()--Exit and reset position cursor 
	local cur_file = vim.fn.expand('%:t')
	vim.cmd.Ex()
	vim.fn.search('^' .. cur_file .. '$')
end, {desc = "Close and go to explorer Ex"})
vim.keymap.set("n", "<C-u>", "u", { silent = true,desc = "Undo"})
vim.keymap.set("i", "<C-u>", "<C-c> u i", { silent = true ,desc = "Undo"})

vim.wo.number = true
vim.wo.relativenumber = true

vim.keymap.set("v", "<S-J>", ":m '>+1<CR>gv=gv",{desc = "Move down"})
vim.keymap.set("n", "<S-J>", "V:m '>+1<CR>gv=gv <C-c>",{desc = "Move down"})
vim.keymap.set("v", "<S-K>", ":m '<-2<CR>gv=gv",{desc = "Move up"})
vim.keymap.set("n", "<S-K>", "V:m '<-2<CR>gv=gv <C-c>",{desc = "Move up"})
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv",{desc = "Move down"})
vim.keymap.set("n", "<S-Down>", "V:m '>+1<CR>gv=gv <C-c>",{desc = "Move down"})
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv",{desc = "Move up"})
vim.keymap.set("n", "<S-Up>", "V:m '<-2<CR>gv=gv <C-c>",{desc = "Move up"})

vim.keymap.set("v", "m", 'y/<C-R>"<CR>',{desc = "Mark to search"})

--vim.keymap.set("n", "<C-c>k", "<cmd>:split<CR>") there is (ctrl + w) +v
--vim.keymap.set("n", "<C-c>l", "<cmd>:vsplit<CR>")there is (ctrl + w) +s

vim.keymap.set("n", "<C-y>", function()
	local regVim = vim.fn.getreg('')
	vim.fn.setreg("*", regVim)
	vim.fn.setreg("+", regVim)
end,{desc = "Copy to clipboard"})

vim.keymap.set("n", "<C-s>", "<C-w>T",{desc = "Move the currect buffer to a new tab"})
vim.keymap.set("n", "<C-c>c", function()
	vim.cmd(":vsplit")
	vim.lsp.buf.definition()
	vim.api.nvim_command('wincmd T')
end,{desc="Create new tab with currect definition buffer"})

vim.keymap.set("n", "<C-p>", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("", path)
end,{desc = "Yank path to register"})

vim.keymap.set("n", "<C-p>o", function()
	vim.cmd(":vsplit")
	vim.cmd("e! " .. vim.fn.getreg(""))
end,{desc = "Open file with path in register"})

vim.keymap.set("n", "<leader>j", "o<C-c>",{desc = "Create a empty line below"})
vim.keymap.set("n", "<leader>k", "O<C-c>",{desc = "Create a empty line above"})
vim.keymap.set("n", "<Tab>", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end,{desc = "Toggle inlay hints"})
