return {
  "ThePrimeagen/git-worktree.nvim",
  cmd = {
  },
  keys = {
    { "<leader>gw", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", desc = "Git Worktree" },
  },
  config = function()
      require("git-worktree").setup({})
      require("telescope").load_extension("git_worktree")
  end,
}