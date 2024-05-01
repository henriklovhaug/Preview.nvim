local M = {}

local function err(msg)
	vim.notify(msg, vim.log.levels.ERROR, { title = "Preview" })
end

local function install()
	if vim.fn.executable("curl") == 0 then
		err("curl is required to install this plugin")
	end
end

local function set_cmd()
	vim.api.nvim_create_user_command("Preview", function(opts)
		print("Preview", opts)
		M.execute()
	end, { complete = "file", nargs = "?", bang = true })
end

local function open_window(file)
	local width = math.floor(vim.o.columns / 2)
	vim.env.MDT_WIDTH = width

	vim.cmd.vsplit()
	vim.cmd.terminal()
	vim.cmd("setlocal nonumber norelativenumber")
	vim.api.nvim_chan_send(vim.bo.channel, "mdt " .. file .. "\r")
	vim.api.nvim_feedkeys("a", "t", false)
	err("Opening Preview " .. width .. " with file " .. file)
end

function M.execute()
	local file = vim.fn.expand("%:p")
	open_window(file)
end

function M.setup()
	print("Setup Preview")
	set_cmd()
end

return M
