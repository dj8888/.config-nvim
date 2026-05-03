return {
	{
		"hat0uma/csvview.nvim",
		ft = { "csv", "tsv" },
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle", "CsvViewInfo" },
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
		},
		config = function(_, opts)
			require("csvview").setup(opts)

			local function enable_if_csv()
				local ft = vim.bo.filetype
				if ft == "csv" or ft == "tsv" then
					vim.cmd("silent! CsvViewEnable")
				end
			end

			local group = vim.api.nvim_create_augroup("CsvViewAutoEnable", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = { "csv", "tsv" },
				callback = enable_if_csv,
			})

			-- If we're loading because we just opened a csv/tsv buffer, enable immediately.
			vim.schedule(enable_if_csv)
		end,
	},
}
