MiniPick = require("mini.pick")
vim.ui.select = MiniPick.ui_select
MiniPick.setup({
	window = {
		config = function()
			local height = math.floor(0.618 * vim.o.lines)
			local width = math.floor(0.618 * vim.o.columns)
			return {
				anchor = "NW",
				height = height,
				width = width,
				row = math.floor(0.5 * (vim.o.lines - height)),
				col = math.floor(0.5 * (vim.o.columns - width)),
			}
		end,
	},
})

require("mini.extra").setup()
require("mini.files").setup()
require("mini.surround").setup()

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		-- Marks
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },

		-- Registers
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },

		-- Window commands
		{ mode = "n", keys = "<C-w>" },

		-- `z` key
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
	window = {
		delay = 2000,
		scroll_down = "<C-d>",
		scroll_up = "<C-u>",
	},
})

local statusline = require("mini.statusline")
statusline.setup()
statusline.section_location = function()
	return "%2l:%-2v"
end

vim.keymap.set("n", "<leader>sf", ":Pick files<CR>", { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sH", ":Pick help<CR>", { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sh", ":Pick history<CR>", { desc = "[S]earch [H]istory" })
vim.keymap.set("n", "<leader>sg", ":Pick grep_live<CR>", { desc = "[S]earch [G]rep" })
vim.keymap.set("n", "<leader>sr", ":Pick resume<CR>", { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>sb", ":Pick buffers<CR>", { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>sc", ":Pick git_commits<CR>", { desc = "[S]earch Git [C]ommits" })
vim.keymap.set("n", "<leader>sb", ":Pick git_branches<CR>", { desc = "[S]earch Git [B]ranches" })
vim.keymap.set("n", "<leader>sk", ":Pick keymaps<CR>", { desc = "[S]earch [K]eymaps" })

vim.keymap.set("n", "\\", function()
	local buf_name = vim.api.nvim_buf_get_name(0)
	local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
	MiniFiles.open(path)
	MiniFiles.reveal_cwd()
end, { desc = "Open Mini Files" })
