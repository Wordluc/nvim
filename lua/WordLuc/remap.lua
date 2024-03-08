	vim.g.mapleader=" "
	vim.keymap.set("n","<leader>z",vim.cmd.Ex)

	vim.keymap.set("n", "<C-u>", "u", { silent = true })
	vim.keymap.set("i", "<C-u>", "<C-c> u i", { silent = true })

	vim.wo.number = true
	vim.wo.relativenumber=true

	vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
	vim.keymap.set("n", "J", "V:m '>+1<CR>gv=gv <C-c>")
	vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
	vim.keymap.set("n", "K", "V:m '<-2<CR>gv=gv <C-c>")

	vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv")
	vim.keymap.set("n", "<S-Down>", "V:m '>+1<CR>gv=gv <C-c>")
	vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv")
	vim.keymap.set("n", "<S-Up>", "V:m '<-2<CR>gv=gv <C-c>")

	vim.keymap.set("v", "m", 'y/<C-R>"<CR>')
	vim.keymap.set("n", "cm", 'cgn')

	vim.keymap.set("n", "<C-c>k", "<cmd>:split<CR>")
	vim.keymap.set("n", "<C-c>l", "<cmd>:vsplit<CR>")

	vim.keymap.set("v", "<C-P>", '"*y')
	vim.keymap.set("n", "<C-P>", '"*yy')

