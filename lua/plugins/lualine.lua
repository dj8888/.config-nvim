return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- pure black, matching kitty/waybar/swaync (nord accent colors on #000000)
		local black = "#000000"
		local fg = "#D8DEE9"
		local dim = "#4C566A"
		local blue = "#81A1C1"
		local green = "#A3BE8C"
		local yellow = "#EBCB8B"
		local red = "#BF616A"
		local magenta = "#B48EAD"

		local function mode(accent)
			return {
				a = { fg = black, bg = accent, gui = "bold" },
				b = { fg = accent, bg = black },
				c = { fg = fg, bg = black },
			}
		end

		local theme = {
			normal = mode(blue),
			insert = mode(green),
			visual = mode(magenta),
			replace = mode(red),
			command = mode(yellow),
			inactive = {
				a = { fg = dim, bg = black },
				b = { fg = dim, bg = black },
				c = { fg = dim, bg = black },
			},
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = false,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{
						function()
							local ok, head = pcall(vim.fn.FugitiveHead)
							return (ok and head) or ""
						end,
						icon = "",
					},
					"diff",
					"diagnostics",
				},
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_c = { {
					"tabs",
					mode = 2,
					separator = { left = "│", right = "" },
					padding = { left = 1, right = 1 },
					tabs_color = {
						active = "lualine_a_normal",
						inactive = "lualine_c_normal",
					},
				} },
			},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
