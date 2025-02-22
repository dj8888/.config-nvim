-- pandoc_zathura.lua

local M = {}

local pdf_file_path = nil -- Store the PDF file path

function M.pandoc_zathura()
	local current_file = vim.api.nvim_buf_get_name(0)
	if vim.fn.filereadable(current_file) == 0 or vim.fn.expand("%:e") ~= "md" then
		vim.api.nvim_echo({ { "Not a markdown file or file not found.", "Error" } }, true, {})
		return
	end

	local pdf_file = vim.fn.expand("%:r") .. ".pdf"
	pdf_file_path = pdf_file -- Store the path

	vim.cmd("w") -- Save the file before running Pandoc

	local pandoc_cmd = "pandoc -o " .. vim.fn.shellescape(pdf_file) .. " " .. vim.fn.shellescape(current_file)

	pandoc_cmd = pandoc_cmd .. " --pdf-engine=xelatex"
	pandoc_cmd = pandoc_cmd .. " -V geometry:margin=1in"

	vim.fn.system(pandoc_cmd)
	local exit_code = vim.v.shell_error

	if exit_code == 0 then
		vim.fn.system("zathura " .. vim.fn.shellescape(pdf_file) .. " &")
	else
		vim.api.nvim_echo({ { "Pandoc conversion failed.", "Error" } }, true, {})
		local output = vim.fn.system(pandoc_cmd)
		vim.api.nvim_echo({ { output } }, true, {})
	end
end

function M.refresh_pdf()
	if pdf_file_path then
		local current_file = vim.api.nvim_buf_get_name(0)
		if vim.fn.filereadable(current_file) == 0 or vim.fn.expand("%:e") ~= "md" then
			vim.api.nvim_echo({ { "Not a markdown file or file not found.", "Error" } }, true, {})
			return
		end

		local pandoc_cmd = "pandoc -o " .. vim.fn.shellescape(pdf_file_path) .. " " .. vim.fn.shellescape(current_file)

		pandoc_cmd = pandoc_cmd .. " --pdf-engine=xelatex"
		pandoc_cmd = pandoc_cmd .. " -V geometry:margin=1in"

		vim.fn.system(pandoc_cmd)
		local exit_code = vim.v.shell_error

		if exit_code ~= 0 then
			vim.api.nvim_echo({ { "Pandoc refresh failed.", "Error" } }, true, {})
			local output = vim.fn.system(pandoc_cmd)
			vim.api.nvim_echo({ { output } }, true, {})
		end
	else
		vim.api.nvim_echo({ { "Run pandoc_zathura first." } }, true, {})
	end
end

return M
