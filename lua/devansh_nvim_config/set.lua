vim.g.netrw_liststyle = 3 -- Set Netrw to tree list view by default
---- Copied from Primagen ----

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.scrolloff = 10
-- vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

--vim.opt.signcolumn = "yes"
--vim.opt.isfname:append("@-@")
--
--vim.opt.updatetime = 50
--
--vim.opt.colorcolumn = "80"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text Try it with `yap` in normal mode See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
