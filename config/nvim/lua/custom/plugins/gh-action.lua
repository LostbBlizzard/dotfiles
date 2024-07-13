--Keybindings
--The following keybindings are provided by the plugin:

--q - closes the gh-actions the split
--gw - open the workflow file below the cursor on GitHub
--gr - open the workflow run below the cursor on GitHub
--gj - open the job of the workflow run below the cursor on GitHub
-- d - dispatch a new run for the workflow below the cursor on GitHub

return {
  'topaxi/gh-actions.nvim',
  keys = {
    { '<leader><C-g>', '<cmd>GhActions<cr>', desc = 'Open Github Actions' },
  },
  -- optional, you can also install and use `yq` instead.
  build = 'make',
  ---@type GhActionsConfig
  opts = {},
}
