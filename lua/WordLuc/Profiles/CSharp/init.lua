print("Welcome to C#")
local uv = require('luv')
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
local addElement = function(path)
	uv.run("nowait") -- This is necessary to start the event loop
	local csprojPath = ""
	local nameCsproj = ""
	local sameLevelElement = ""
	local nameFile = path:match("([^/\\]+)$")
	for entry, type in vim.fs.dir(path:sub(1, - #nameFile - 1)) do
		if type == "file" then
			if entry ~= nameFile then
				sameLevelElement = entry
				break
			end
		end
	end
	--sameLevelElement = vim.fs.joinpath(path, sameLevelElement)

	vim.fs.find(function(name, _path)
		if name:match("%.csproj$") then
			csprojPath = _path
			nameCsproj = name
			return true
		end
		return false
	end, { upward = true, type = "file", limit = math.huge, path = path })
	local pathRelativeFile = ""
	if pathRelativeFile == nil then
		print("Error adding element")
		return
	end
	pathRelativeFile = path:sub(#csprojPath + 2)
	local nameRelativeFile = pathRelativeFile:match("([^/\\]+)$")
	pathRelativeFile = pathRelativeFile:gsub("/", "\\")
	sameLevelElement = pathRelativeFile:sub(1, - #nameRelativeFile - 2) .. "\\" .. sameLevelElement
	sameLevelElement = sameLevelElement:gsub("/", "\\")
	local stdin = uv.new_pipe()
	local stdout = uv.new_pipe()
	local stderr = uv.new_pipe()
	--local script_path = debug.getinfo(1, "S").source:sub(2)
	--local executable_path = script_path:match(".*/") .. "path from package lua"
	local executable_path = "C:\\Users\\Usernexus\\Desktop\\PersonalProject\\AddElementToCsproj\\AddElementToCsproj.exe"
	local handle, pid = uv.spawn(
		executable_path
		, { stdio = { stdin, stdout, stderr } }, function()
			stdin:close()
			stdout:close()
			stderr:close()
		end
	)
	if not pid or not handle then
		print("Error adding element")
		return
	end
	local input = {
		CsprojPath = vim.fs.joinpath(csprojPath, nameCsproj),
		WhenAddElement = sameLevelElement,
		ElementToAdd = string.format('<Compile Include="%s" />', pathRelativeFile)
	}
	local json = vim.fn.json_encode(input)
	stdin:write(json .. "\n")
	stdout:read_start(function(e, data)
		assert(not e, e)
		if data then
			vim.schedule(function()
				print(data)
				require("roslyn.slnutils").did_change_watched_file(vim.uri_from_bufnr(0))
			end)
		end
	end)
	stderr:read_start(function(e, data)
		assert(not e, e)
		if data then
			print(data)
		end
	end)
end

vim.api.nvim_create_user_command('AddedFile', function() --da attaccare a treeneovim
	addElement(vim.fn.expand("%:p"))
end, { bang = true, nargs = '*' })

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
