function PickString(title, strings, callback)
	local pickers = require "telescope.pickers"
	local finders = require "telescope.finders"
	local actions = require "telescope.actions"
	local conf = require("telescope.config").values
	local actions_state = require("telescope.actions.state")
	pickers.new({}, {
		prompt_title = title,
		finder = finders.new_table {
			results = strings
		},
		attach_mappings = function(prompt_bufnr, _)
			actions.select_default:replace(function()
				local selected_entry = actions_state.get_selected_entry().value
				actions.close(prompt_bufnr)
				callback(selected_entry)
			end)
			return true
		end,
		sorter = conf.generic_sorter({}),
	}):find()
end

function OpenWindowGetOuput(cmd, callback)
	local Popup = require("nui.popup")
	local event = require("nui.utils.autocmd").event

	local popup = Popup({
		enter = true,
		focusable = true,
		border = {
			style = "rounded",
			text = {
				top = "pass",
			},
		},
		position = "50%",
		size = {
			width = "90%",
			height = "90%",
		},
	})

	local function closepasspopup(currentpopup)
		currentpopup:unmount()
		vim.cmd("silent! :checktime")
	end
	popup:mount()

	popup:on(event.BufLeave, function()
		closepasspopup(popup)
	end)

	popup:on({ "VimResized", "WinResized" }, function()
		popup:update_layout()
		vim.api.nvim_win_set_cursor(0, { 1, 0 })
	end)

	vim.fn.termopen(cmd, {
		on_exit = function()
			closepasspopup(popup)
			callback(vim.fn.systemlist(cmd)[1])
		end,
	})
end

function OpenVimTrello()
	local cmd = "cd ~/.password-store/ && find ./ -type f -name \"*.gpg\""
	local output_lines = vim.fn.systemlist(cmd)

	if not (vim.g.vimTrelloApiKey == nil and vim.g.vimTrelloToken == nil) then
		vim.cmd("VimTrello")
	else
		PickString("TrelloAPIKey", output_lines, function(selected_entry)
			local newstring = string.sub(selected_entry, 3, string.len(selected_entry) - 4)
			OpenWindowGetOuput("pass " .. newstring, function(APIKey)
				PickString("TrelloToken", output_lines, function(selected_entry)
					local newstring = string.sub(selected_entry, 3, string.len(selected_entry) - 4)
					OpenWindowGetOuput("pass " .. newstring, function(Token)
						vim.g.vimTrelloApiKey = APIKey
						vim.g.vimTrelloToken  = Token

						vim.cmd("VimTrello")
					end)
				end)
			end)
		end
		)
	end
end

return {
	"yoshio15/vim-trello",

	cmd = {
		'VimTrello',
	},
	keys = {
		{ '<leader><C-t>', OpenVimTrello, desc = 'VimTrello' },
	},
}
