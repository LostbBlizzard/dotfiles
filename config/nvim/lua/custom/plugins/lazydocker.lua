return {
  'crnvl96/lazydocker.nvim',
  event = 'VeryLazy',
  opts = {}, -- automatically calls `require("lazydocker").setup()`
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader><C-l>', '<cmd>LazyDocker<cr>', desc = 'LazyDocker' },
  },
}
