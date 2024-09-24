return {
	'monkoose/neocodeium',
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
		vim.keymap.set("i", "<Tab>", function()
			neocodeium.accept()
		end)
		vim.keymap.set("i", "<C-l>", function()
			neocodeium.cycle_or_complete(1)
		end)
		vim.keymap.set("n", "<C-a>", function()
			neocodeium.chat()
		end)
		vim.keymap.set("n", "<C-x>", function()
			neocodeium.clear()
		end)
	end


}
