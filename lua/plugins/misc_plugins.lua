return {
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{
		"hzchirs/vim-material",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- enable truecolor so Kitty hex colors are used
			vim.opt.termguicolors = true

			-- load the colorscheme here
			vim.cmd([[
				let g:material_style='oceanic'
				set background=dark
				colorscheme vim-material
			      ]])

			-- Transparent backgrounds (vim-material handles the rest)
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

			-- Sign column (line change "H", diagnostics, etc.) transparent like line numbers
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
			vim.api.nvim_set_hl(0, "DiffAdd", { bg = "none" })
			vim.api.nvim_set_hl(0, "DiffChange", { bg = "none" })
			vim.api.nvim_set_hl(0, "DiffDelete", { bg = "none" })
			vim.api.nvim_set_hl(0, "DiffText", { bg = "none" })

			-- Native statusline fallback (lualine overrides this whenever it's active)
			vim.api.nvim_set_hl(0, "StatusLine", { fg = "#D8DEE9", bg = "#000000" })
			vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#4C566A", bg = "#000000" })
		end,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({ default_file_explorer = false })
			vim.keymap.set("n", "<leader>-", "<cmd>Oil<CR>", { desc = "Oil: open parent directory" })
		end,
	},
	"mbbill/undotree",
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", function() vim.cmd("vertical Git") end, { desc = "Git: open fugitive status" })
		end,
	},
}
