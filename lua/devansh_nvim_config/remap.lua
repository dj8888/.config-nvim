vim.g.mapleader = " "
vim.g.maplocalleader = " "
--vim.g.maplocalleader = '\\'

----from Primagen----
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "[P]roject [V]iew: open netrw at project root" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })

--quickly navigate the quick fix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Quickfix: next item" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Quickfix: prev item" })
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz", { desc = "Loclist: next item" })
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz", { desc = "Loclist: prev item" })

--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer (LSP)" })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected block up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below without moving cursor" })
--the following keep the cursor in the middle of the screen when jumping around
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half page (cursor centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page (cursor centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor (global)" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

-- greatest remap ever, can now delete without destoring the buffer!!
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over selection without yanking" })

---- from kickstart.nvim -----
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Load all diagnostics into loclist (then <leader>j/k to jump)" })

-- Build note PDF into ~/Documents/notes/pdf/ on save (no PATH needed).
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*note-*.md",
	callback = function()
		local buildNote = vim.fn.expand("~") .. "/.config/hypr/scripts/buildNote"
		vim.cmd("silent !" .. vim.fn.shellescape(buildNote) .. " " .. vim.fn.shellescape(vim.fn.expand("%:p")))
	end,
})

-- PDF preview for Markdown files (leader+pd: buildPDF with Mermaid support; builds beside file, opens Zathura).
-- Skip note-*.md; those use buildNote and output to ~/Documents/notes/pdf/.
-- vim.keymap.set("n", "<leader>pd", '<cmd>lua require("devansh_nvim_config.pandoc_zathura").pandoc_zathura()<CR>')  -- old: pandoc_zathura (no Mermaid)
vim.keymap.set("n", "<leader>pd", function()
	local f = vim.fn.expand("%:p")
	if vim.fn.filereadable(f) == 0 or vim.fn.expand("%:e") ~= "md" then
		vim.api.nvim_echo({ { "Not a markdown file or file not found.", "Error" } }, true, {})
		return
	end
	local buildPDF = vim.fn.expand("~") .. "/.config/hypr/scripts/buildPDF"
	vim.cmd("!" .. vim.fn.shellescape(buildPDF) .. " " .. vim.fn.shellescape(f))
	vim.b.buildpdf_refresh_on_save = true -- refresh this buffer's PDF on subsequent :w
end, { desc = "Build PDF from markdown (Mermaid support, opens Zathura)" })
-- On save: rebuild PDF only for non-note .md buffers where leader+pd was already run.
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.md",
	callback = function()
		if vim.fn.expand("%:t"):match("^note%-") then
			return
		end
		if not vim.b.buildpdf_refresh_on_save then
			return
		end
		local f = vim.fn.expand("%:p")
		if vim.fn.filereadable(f) == 0 then
			return
		end
		local buildPDF = vim.fn.expand("~") .. "/.config/hypr/scripts/buildPDF"
		vim.fn.jobstart({ "sh", "-c", vim.fn.shellescape(buildPDF) .. " " .. vim.fn.shellescape(f) }, { detach = true })
	end,
})
