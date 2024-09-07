return {
  'ThePrimeagen/harpoon',
  keys = {
    { '<leader>e',     '<cmd>:lua require("harpoon.mark").add_file()<cr>',        desc = 'Add File to harpoon' },
    { '<leader><C-e>', '<cmd>:lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = 'Harpoon Menu' },

    { '<leader>a',     '<cmd>:lua require("harpoon.ui").nav_file(1)<cr>',         desc = 'Harpoon Nav File 1' },
    { '<leader>f',     '<cmd>:lua require("harpoon.ui").nav_file(2)<cr>',         desc = 'Harpoon Nav File 2' },
    { '<leader>j',     '<cmd>:lua require("harpoon.ui").nav_file(3)<cr>',         desc = 'Harpoon Nav File 3' },
    { '<leader>l',     '<cmd>:lua require("harpoon.ui").nav_file(4)<cr>',         desc = 'Harpoon Nav File 4' },
  }
}
