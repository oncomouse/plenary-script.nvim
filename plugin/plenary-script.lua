--luacheck: globals vim
local files = {}

vim.cmd([[augroup plenary-script.nvim
	autocmd!
augroup END]])

local function read_post()
	local file = vim.api.nvim_buf_get_name(0)
	if not files[file] then
		vim.opt_local.filetype = require'plenary.filetype'.detect(file, {})
	end
end

local function filetype()
	local file = vim.api.nvim_buf_get_name(0)
	files[file] = true
end

_G.plenary_script = {
	read_post = read_post,
	filetype = filetype,
}

vim.cmd("autocmd! plenary-script.nvim BufReadPost * lua plenary_script.read_post()")
vim.cmd("autocmd! plenary-script.nvim FileType * lua plenary_script.filetype()")

