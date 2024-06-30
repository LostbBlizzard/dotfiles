return {
  "LostbBlizzard/lazysql.nvim",
  opts = {}, -- automatically calls `require("lazydocker").setup()`
  cmd = {
    'LazySql',
  },
  keys = {
    { '<leader><C-s>', '<cmd>LazySql<cr>', desc = 'LazySql' },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  }
}
