print("Welcome to C#")
--Default_setup("csharp_ls")
require("roslyn").setup({
	choose_sln = function(strs)
		if not EnvManage.isEnv(EnvEnum.wki) then
			return
		end
		if vim.g.roslyn_nvim_selected_solution ~= nil then
			if vim.g.roslyn_nvim_selected_solution:find("GenyaALL.sln") ~= nil then
				print("Load All")
				return vim.g.roslyn_nvim_selected_solution
			end
		end
		local path = vim.fn.expand("%:.")
		local i = 0
		local segment1
		local segment2
		for seg in path:gmatch("[^\\|/|.]+") do
			if i == 1 then
				segment1 = seg
			end
			if i == 2 then
				segment2 = seg
				break
			end
			i = i + 1
		end
		local restart_client = false
		for _, str in ipairs(strs) do
			if segment1 ~= nil then
				if str:find(segment1) ~= nil then
					if vim.g.roslyn_nvim_selected_solution ~= nil then
						if vim.g.roslyn_nvim_selected_solution:find(segment1) == nil then
							restart_client = true
						end
					end
					if restart_client then
						vim.lsp.stop_client(vim.lsp.get_clients({ name = "roslyn" }), true)
					end
					return str
				end
			end
			if segment2 ~= nil then
				if str:find(segment2) ~= nil then
					if vim.g.roslyn_nvim_selected_solution ~= nil then
						if vim.g.roslyn_nvim_selected_solution:find(segment2) == nil then
							restart_client = true
						end
					end
					if restart_client then
						vim.lsp.stop_client(vim.lsp.get_clients({ name = "roslyn" }), true)
					end
					return str
				end
			end
		end
	end,
	filewatching = false,
	config = {
		capabilities = require("lspconfig").default_config.capabilities,
		cmd = {
			"dotnet",
			vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn", "Microsoft.CodeAnalysis.LanguageServer.dll"),
		},
		settings = {
			["csharp|background_analysis"] = {
				background_analysis = {
					dotnet_analyzer_diagnostics_scope = "openFiles",
					dotnet_compiler_diagnostics_scope = "openFiles"
				}
			},
			["csharp|inlay_hints"] = {
				csharp_enable_inlay_hints_for_implicit_object_creation = true,
				csharp_enable_inlay_hints_for_implicit_variable_types = true,
				csharp_enable_inlay_hints_for_lambda_parameter_types = true,
				csharp_enable_inlay_hints_for_types = true,
				dotnet_enable_inlay_hints_for_indexer_parameters = true,
				dotnet_enable_inlay_hints_for_literal_parameters = true,
				dotnet_enable_inlay_hints_for_object_creation_parameters = true,
				dotnet_enable_inlay_hints_for_other_parameters = true,
				dotnet_enable_inlay_hints_for_parameters = true,
				dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
				dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
				dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
			},
			["csharp|code_lens"] = {
				dotnet_enable_references_code_lens = true,
			},
		}
	}
})
vim.api.nvim_create_autocmd("BufWinEnter",{
	callback = function()
		for _, client in ipairs(vim.lsp.get_active_clients()) do
			if client.name == "roslyn" then
				client.request_sync("workspace/didChangeWatchedFiles",{
					changes ={
                 {uri=vim.uri_from_bufnr(0),type=2}
					}
				},0,0)
			end
		end
	end
})
vim.api.nvim_create_user_command('Gnamespace', function()
	local dir = vim.fn.expand("%:.")
	local namespace = {}
	for segment in dir:gmatch("[^/|\\]+") do
		table.insert(namespace, segment)
	end
	local newPath = table.concat(namespace, ".", 1, #namespace - 1)
	vim.api.nvim_feedkeys("inamespace " .. newPath .. ";", "n", true)
end, { bang = true, nargs = '*' })
vim.api.nvim_create_user_command('Gtypescript', function()
	require("FromC#ToTypescript")
	.convertDto()
end, { bang = true, nargs = '*' })

local glob = require('vim.glob')
local poll = require("vim.lsp._watchfiles")._poll_exclude_pattern
poll = poll + glob.to_lpeg("**/*.{csproj,sln,slnf}")
poll = poll + glob.to_lpeg("**/bin/**")
poll = poll + glob.to_lpeg("**/obj/**")
require("vim.lsp._watchfiles")._poll_exclude_pattern = poll
