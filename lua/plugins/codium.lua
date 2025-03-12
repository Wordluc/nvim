return {
	'monkoose/neocodeium',
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
		vim.keymap.set("i", "<A-a>", function()
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
			local options = require("neocodeium.options").options
			local M = require("neocodeium.commands")
			if options.enabled then
				M.disable()
				require("neocodeium.completer"):clear(true)
				print("Stop codeium")
			else
				M.enable()
			end
		end)
	end


}
