return {
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			vim.api.nvim_set_keymap(
				"n",
				"<leader>db",
				"<cmd>daptogglebreakpoint<cr>",
				{ noremap = true, silent = true, desc = "dap: add breakpoint at line" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>dr",
				"<cmd>dapcontinue<cr>",
				{ noremap = true, silent = true, desc = "dap: start or continue the debugger" }
			)
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
		},
		opts = {
			handlers = {},
		},
	},
}
