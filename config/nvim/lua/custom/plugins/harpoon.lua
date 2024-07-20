function close_buffers_right()
  local wason_bufnr = vim.fn.bufnr('%')

  vim.cmd('bfirst')
  local bufftostop = vim.fn.bufnr('%')

  vim.cmd('b' .. wason_bufnr)

  vim.cmd('bnext')


  while wason_bufnr ~= vim.fn.bufnr('%') do
    local current_bufnr = vim.fn.bufnr('%')

    if current_bufnr == wason_bufnr then
      break
    end
    if current_bufnr == bufftostop then
      break
    end

    vim.cmd('bd')
    vim.cmd('bnext')
  end

  vim.cmd('b' .. wason_bufnr)
  print("closed right buffers")
end

function close_buffers_left()
  local wason_bufnr = vim.fn.bufnr('%')

  vim.cmd('blast')
  local bufftostop = vim.fn.bufnr('%')

  vim.cmd('b' .. wason_bufnr)

  vim.cmd('bprev')


  while wason_bufnr ~= vim.fn.bufnr('%') do
    local current_bufnr = vim.fn.bufnr('%')

    if current_bufnr == wason_bufnr then
      break
    end
    if current_bufnr == bufftostop then
      break
    end

    vim.cmd('bd')
    vim.cmd('bprev')
  end

  vim.cmd('b' .. wason_bufnr)
  print("closed buffers left")
end

function close_other_buffers()
  vim.cmd("bufdo bd")
  vim.cmd("e#")
  print("closed other buffers")
end

return {
  'ThePrimeagen/harpoon',
  keys = {
    { '<leader>pa', '<cmd>:lua require("harpoon.mark").add_file()<cr>',        desc = 'Add File to harpoon' },
    { '<leader>pu', '<cmd>:lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = 'Harpoon Menu' },

    { '<leader>l',  '<cmd>:lua require("harpoon.ui").nav_next()<cr>',          desc = 'Harpoon Nav File Next' },
    { '<leader>h',  '<cmd>:lua require("harpoon.ui").nav_prev()<cr>',          desc = 'Harpoon Nav File Prev' },

    { '<leader>p1', '<cmd>:lua require("harpoon.ui").nav_file(1)<cr>',         desc = 'Harpoon Nav File 1' },
    { '<leader>p2', '<cmd>:lua require("harpoon.ui").nav_file(2)<cr>',         desc = 'Harpoon Nav File 2' },
    { '<leader>p3', '<cmd>:lua require("harpoon.ui").nav_file(3)<cr>',         desc = 'Harpoon Nav File 3' },
    { '<leader>p4', '<cmd>:lua require("harpoon.ui").nav_file(4)<cr>',         desc = 'Harpoon Nav File 4' },
    { '<leader>p5', '<cmd>:lua require("harpoon.ui").nav_file(5)<cr>',         desc = 'Harpoon Nav File 5' },
    { '<leader>p6', '<cmd>:lua require("harpoon.ui").nav_file(6)<cr>',         desc = 'Harpoon Nav File 6' },
    { '<leader>p7', '<cmd>:lua require("harpoon.ui").nav_file(7)<cr>',         desc = 'Harpoon Nav File 7' },
    { '<leader>p8', '<cmd>:lua require("harpoon.ui").nav_file(8)<cr>',         desc = 'Harpoon Nav File 8' },
    { '<leader>p9', '<cmd>:lua require("harpoon.ui").nav_file(9)<cr>',         desc = 'Harpoon Nav File 9' },

    { '<leader>k',  '<cmd>:bnext<cr>',                                         desc = 'Buffer File Next' },
    { '<leader>j',  '<cmd>:bprev<cr>',                                         desc = 'Buffer File Prev' },

    { '<leader>1',  '<cmd>:bfirst<cr>' },
    { '<leader>2',  '<cmd>:bfirst<cr><cmd>:bnext<cr>' },
    { '<leader>3',  '<cmd>:bfirst<cr><cmd>:2bnext<cr>' },
    { '<leader>4',  '<cmd>:bfirst<cr><cmd>:3bnext<cr>' },
    { '<leader>5',  '<cmd>:bfirst<cr><cmd>:4bnext<cr>' },
    { '<leader>6',  '<cmd>:bfirst<cr><cmd>:5bnext<cr>' },
    { '<leader>7',  '<cmd>:bfirst<cr><cmd>:6bnext<cr>' },
    { '<leader>8',  '<cmd>:bfirst<cr><cmd>:7bnext<cr>' },
    { '<leader>9',  '<cmd>:bfirst<cr><cmd>:8bnext<cr>' },


    { '<leader>H',  '<cmd>:lua close_buffers_left()<cr>',                      desc = "close buffer left" },
    { '<leader>L',  '<cmd>:lua close_buffers_right()<cr>',                     desc = "close buffer right" },
    { '<leader>A',  '<cmd>:lua close_other_buffers()<cr>',                     desc = "close other buffers" },
  },
}
