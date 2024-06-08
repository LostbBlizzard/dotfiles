
vim.api.nvim_set_keymap('n', '<leader>b', ':OverseerToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>r', ':OverseerRun<CR>', {noremap = true, silent = true})

return {
  'stevearc/overseer.nvim',
  opts = {templates = { }},
}

