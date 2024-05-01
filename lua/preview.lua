local M = {}

local function err(msg)
	vim.notify(msg, vim.log.levels.ERROR, { title = "Preview" })
end

local function install()
	if vim.fn.executable("curl") == 0 then
		err("curl is required to install this plugin")
	end

	local version = "0.7.1"

	local install_script = "curl --proto '=https' --tlsv1.2 -LsSf https://github.com/henriklovhaug/md-tui/releases/download/v"
		.. version
		.. "/md-tui-installer.sh | sh"
	vim.fn.system(install_script)
end

local function set_cmd()
	vim.api.nvim_create_user_command("Preview", function(opts)
		M.execute(opts)
	end, { complete = "file", nargs = "?", bang = true })
end

local function open_window(file)
	local width = math.floor(vim.o.columns / 2) - 2
	vim.env.MDT_WIDTH = width

	vim.cmd.vnew()
	vim.fn.termopen("mdt " .. file)

	vim.cmd("setlocal nonumber norelativenumber")
	vim.api.nvim_feedkeys("a", "t", false)
end

function M.execute(opts)
	local file

	if opts.fargs[1] == nil then
		file = vim.fn.expand("%:p")
	else
		file = opts.fargs[1]
	end

	open_window(file)
end

function M.setup()
	-- Check if "mdt" is installed
	if vim.fn.executable("mdt") == 0 then
		install()
	end

	set_cmd()
end

return M
