-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

ShouldAttach = false
vim.api.nvim_create_user_command('ShouldAttach', function()
  ShouldAttach = not ShouldAttach

  if ShouldAttach then
    print 'ShouldAttach is On'
  else
    print 'ShouldAttach is Off'
  end
end, {})

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    'theHamsta/nvim-dap-virtual-text',
    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require("nvim-dap-virtual-text").setup(
      {
        virt_text_pos = 'inline'
      }
    )
    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'codelldb',
      },
    }

    vim.keymap.set('n', '<leader>dk', function()
      require('dapui').eval(nil, { enter = true });
    end)
    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>dl', dap.continue, { desc = 'Debug: Start/Continue' })
    --[[
    vim.keymap.set('n', '<leader>dl', function()
      if ShouldAttach then
        vim.ui.input({ prompt = 'Attach To Process ID: ' },
          function(input)
            if input == "" then
              print("Not Starting Because there was no Process ID")
              return
            end

            isword = true

            if isword then
              local output = vim.fn.system('ps ax | grep ' .. input)
              vim.ui.input({ prompt = output .. ' Process: ' },
                function(input)
                  dap.adapters.cppdbg = {
                    type = 'executable',
                    command = 'codelldb', -- Adjust as needed
                    name = "cppdbg"
                  }

                  local config = {
                    name = "Attach to PID",
                    type = "cppdbg",
                    request = "attach",
                    pid = input,
                    cwd = "${workspaceFolder}",
                    stopAtEntry = true,
                  }

                  dap.run(config, {})
                end)
            else
              dap.attach('cpp', { pid = input })
            end
          end);
      else
        dap.continue();
      end
    end
    , { desc = 'Debug: Start/Continue' })
    --]]

    vim.keymap.set('n', '<leader>dx', dap.disconnect, { desc = 'Debug: Close/Stop Debugging' })
    vim.keymap.set('n', '<leader>dp', dap.pause, { desc = 'Debug: Pause' })

    vim.keymap.set('n', '<leader>do', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>di', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>dh', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>dj', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>du', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    dap.defaults.cpp.exception_breakpoints = { 'raised' }
    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
