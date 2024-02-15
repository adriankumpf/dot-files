return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
		keys = {
			{
				"<leader>f",
				function()
					if require("utils").is_git_repo() then
						require("telescope.builtin").git_files({ show_untracked = true })
					else
						require("telescope.builtin").find_files()
					end
				end,
				desc = "Find Files (Project)",
			},
			{
				"<leader>r",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Find in Files (Grep)",
			},
			{
				"<leader>a",
				function()
					require("telescope.builtin").find_files({ follow = true, no_ignore = true, hidden = true })
				end,
				desc = "Find Files (All)",
			},
			{
				"<leader>b",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>h",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Help Pages",
			},
			{
				"<leader>o",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "Recent",
			},
			{
				"<leader>tk",
				function()
					require("telescope.builtin").keymaps()
				end,
				desc = "Keymaps",
			},
			{
				",S",
				function()
					require("telescope.builtin").grep_string({ use_regex = true })
				end,
				desc = "Find Word",
			},
			{
				"<leader>gc",
				function()
					require("telescope.builtin").git_commits()
				end,
				"Git commits",
			},
			{
				"<leader>gs",
				function()
					require("telescope.builtin").git_status()
				end,
				"Git Status",
			},
		},
		config = function()
			local telescope = require("telescope")

			local options = {
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--trim",
					},
					path_display = { "truncate" },
					set_env = { ["COLORTERM"] = "truecolor" },
					mappings = {
						i = { ["<esc>"] = require("telescope.actions").close },
					},
				},
				-- pickers = {
				-- 	-- Previwe and go to line when searching for "filename:line_number"
				-- 	-- https://github.com/nvim-telescope/telescope.nvim/issues/1042
				-- 	find_files = {
				-- 		on_input_filter_cb = function(prompt)
				-- 			local find_colon = string.find(prompt, ":")
				-- 			if find_colon then
				-- 				local ret = string.sub(prompt, 1, find_colon - 1)
				-- 				vim.schedule(function()
				-- 					local prompt_bufnr = vim.api.nvim_get_current_buf()
				-- 					local picker = action_state.get_current_picker(prompt_bufnr)
				-- 					local lnum = tonumber(prompt:sub(find_colon + 1))
				-- 					if type(lnum) == "number" then
				-- 						local win = picker.previewer.state.winid
				-- 						local bufnr = picker.previewer.state.bufnr
				-- 						local line_count = vim.api.nvim_buf_line_count(bufnr)
				-- 						vim.api.nvim_win_set_cursor(win, { math.max(1, math.min(lnum, line_count)), 0 })
				-- 					end
				-- 				end)
				-- 				return { prompt = ret }
				-- 			end
				-- 		end,
				-- 		attach_mappings = function()
				-- 			actions.select_default:enhance({
				-- 				post = function()
				-- 					-- if we found something, go to line
				-- 					local prompt = action_state.get_current_line()
				-- 					local find_colon = string.find(prompt, ":")
				-- 					if find_colon then
				-- 						local lnum = tonumber(prompt:sub(find_colon + 1))
				-- 						vim.api.nvim_win_set_cursor(0, { lnum, 0 })
				-- 					end
				-- 				end,
				-- 			})
				-- 			return true
				-- 		end,
				-- 	},
				-- },
			}

			telescope.setup(options)
			telescope.load_extension("fzf")
		end,
	},
}
