print("Welcome to C#")
require("roslyn").setup({
	filewatching = false,
	config = {
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

require("roslyntree").setupCsprojOperation()
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
