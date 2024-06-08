-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.api.nvim_set_keymap('n', '<leader>t', ':ToggleTerm<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-\\><C-n>', '<C-\\><C-n><CR>', {noremap = true})
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>:q<CR><Esc>', {noremap = true})

return {
    {'akinsho/toggleterm.nvim', version = "*", opts = {--[[ things you want to change go here]]}}
}
