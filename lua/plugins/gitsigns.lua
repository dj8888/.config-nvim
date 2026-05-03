return {
	"lewis6991/gitsigns.nvim",
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			vim.keymap.set("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Git: Next hunk" })
			vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Git: Prev hunk" })
			vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Git: [H]unk [P]review (show original lines)" })
			vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Git: [H]unk [R]eset (discard this change)" })
			vim.keymap.set("n", "<leader>hb", gs.blame_line, { buffer = bufnr, desc = "Git: [H]unk [B]lame line" })
		end,
	},
}
