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

			-- Statusline (lualine) use full kitty.conf palette
			local k = {
				fg       = "#D8DEE9",   -- foreground
				bg       = "#3B4252",   -- color0
				surface  = "#4C566A",    -- color8
				red      = "#BF616A",   -- color1
				green    = "#A3BE8C",   -- color2
				yellow   = "#EBCB8B",   -- color3
				blue     = "#81A1C1",   -- color4
				magenta  = "#B48EAD",   -- color5
				cyan     = "#88C0D0",   -- color6
				white    = "#E5E9F0",   -- color7
				url      = "#FF4151",   -- url_color / cursor
			}
			vim.api.nvim_set_hl(0, "StatusLine", { fg = k.fg, bg = k.bg })
			vim.api.nvim_set_hl(0, "StatusLineNC", { fg = k.surface, bg = k.bg })
			vim.api.nvim_set_hl(0, "StatusLineSectionA", { fg = k.bg, bg = k.blue, bold = true })   -- mode
			vim.api.nvim_set_hl(0, "StatusLineSectionB", { fg = k.green, bg = k.bg })             -- branch, diff, diagnostics
			vim.api.nvim_set_hl(0, "StatusLineSectionC", { fg = k.fg, bg = k.bg })                -- filename
			vim.api.nvim_set_hl(0, "StatusLineSectionX", { fg = k.cyan, bg = k.bg })               -- encoding, filetype
			vim.api.nvim_set_hl(0, "StatusLineSectionY", { fg = k.yellow, bg = k.bg })             -- progress
			vim.api.nvim_set_hl(0, "StatusLineSectionZ", { fg = k.bg, bg = k.blue, bold = true })   -- location
		end,
	},
	"mbbill/undotree",
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},
}
