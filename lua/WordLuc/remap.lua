vim.g.mapleader = " "
vim.keymap.set("n", "<leader>z", vim.cmd.Ex)

vim.keymap.set("n", "<C-u>", "u", { silent = true })
vim.keymap.set("i", "<C-u>", "<C-c> u i", { silent = true })

vim.wo.number = true
vim.wo.relativenumber = true

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

vim.keymap.set("v", "<C-y>", '"*y')
vim.keymap.set("n", "<C-y>", '"*yy')

vim.keymap.set("n", "<C-s>", "<C-w>T")
vim.keymap.set("n", "<C-s>c", function()
	vim.cmd(":vsplit")
	vim.lsp.buf.definition()
	vim.api.nvim_command('wincmd T')
end)

vim.keymap.set("n", ":code", function()
	local path = vim.fn.shellescape(vim.fn.expand("%:p"))
	print(path)
	vim.cmd(":!code " .. path)
end)
