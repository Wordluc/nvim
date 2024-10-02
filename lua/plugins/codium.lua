return {
	'monkoose/neocodeium',
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
		vim.keymap.set("i", "<M-a>", function()
			neocodeium.accept()
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<C-l>", function()
			neocodeium.cycle(1)
		end)
		vim.keymap.set("i", "<C-h>", function()
			neocodeium.cycle(-1)
		end)
		vim.keymap.set("i", "<C-Left>", function()
			neocodeium.cycle(1)
		end)
		vim.keymap.set("i", "<C-Right>", function()
			neocodeium.cycle(-1)
		end)
		vim.keymap.set("n", "<C-a>", function()
			neocodeium.chat()
		end)
		vim.keymap.set("i", "<C-x>", function()
			neocodeium.clear()
		end)
	end


}
