vim.g.mapleader = " "
vim.g.maplocalleader = " "
--vim.g.maplocalleader = '\\'

----from Primagen----
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) --open netrw --project view.. opens the root directory in which nvim has started **

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) --yank to global clipboard

--quickly navigate the quick fix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format) -- format code

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") --to move selected block of text. #awesome!!
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z") --appending using J doesn't move the cursor
--the following keep the cursor in the middle of the screen when jumping around
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- global substitution for selected word
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- makes current file executable

-- greatest remap ever, can now delete without destoring the buffer!!
vim.keymap.set("x", "<leader>p", [["_dP]])

---- from kickstart.nvim -----
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- add the hypr/scripts to path in .zshenv for this to work.
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*note-*.md",
	callback = function()
		vim.cmd("silent !buildNote " .. vim.fn.expand("%:p"))
	end,
})

-- PDF preview for Markdown files
vim.keymap.set("n", "<leader>pd", '<cmd>lua require("devansh_nvim_config.pandoc_zathura").pandoc_zathura()<CR>')
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.md",
	callback = function()
		require("devansh_nvim_config.pandoc_zathura").refresh_pdf()
	end,
})
