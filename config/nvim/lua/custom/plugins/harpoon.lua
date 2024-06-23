return {
  'ThePrimeagen/harpoon',
  keys = {
    { '<leader>pa', '<cmd>:lua require("harpoon.mark").add_file()<cr>', desc = 'Add File to harpoon' },
    { '<leader>pu', '<cmd>:lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = 'Harpoon Menu' },

    { '<leader>l', '<cmd>:lua require("harpoon.ui").nav_next()<cr>', desc = 'Harpoon Nav File Next' },
    { '<leader>h', '<cmd>:lua require("harpoon.ui").nav_prev()<cr>', desc = 'Harpoon Nav File Prev' },

    { '<leader>k', '<cmd>:bnext<cr>', desc = 'Harpoon Nav File Next' },
    { '<leader>j', '<cmd>:bprev<cr>', desc = 'Harpoon Nav File Prev' },

    { '<leader>p1', '<cmd>:lua require("harpoon.ui").nav_file(1)<cr>', desc = 'Harpoon Nav File 1' },
    { '<leader>p2', '<cmd>:lua require("harpoon.ui").nav_file(2)<cr>', desc = 'Harpoon Nav File 2' },
    { '<leader>p3', '<cmd>:lua require("harpoon.ui").nav_file(3)<cr>', desc = 'Harpoon Nav File 3' },
    { '<leader>p4', '<cmd>:lua require("harpoon.ui").nav_file(4)<cr>', desc = 'Harpoon Nav File 4' },
    { '<leader>p5', '<cmd>:lua require("harpoon.ui").nav_file(5)<cr>', desc = 'Harpoon Nav File 5' },
  },
}
