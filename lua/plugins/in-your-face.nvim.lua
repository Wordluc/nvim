return {
	"Wordluc/in-your-face.nvim",
	config=function ()
		vim.api.nvim_create_user_command('DoomFace', function()
			local opt={
				windows={
					x=vim.fn.winwidth(0)-48,
					y=0,
				},

			}
			require("in-your-face").setup(opt);
		end, { bang = true, nargs = '*' })
	end
}
