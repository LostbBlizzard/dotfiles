return {
  "tpope/vim-fugitive",
  cmd = {
  },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>",        desc = "Git status" },
    { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
    { "<leader>gp", "<cmd>Git pull<cr>",   desc = "Git pull" },
    { "<leader>gP", "<cmd>Git push<cr>",   desc = "Git push" },
    { "<leader>gd", "<cmd>Gdiff<cr>",      desc = "Git diff" }
  }
}
