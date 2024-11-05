-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

local function SetGodotMode(Isgodotproject, Print)
  if Isgodotproject then
    local dap = require 'dap'

    local config = {
      {
        type = 'godot',
        name = 'Run Scene',
        request = 'launch',
        stopAtEntry = false,
        cwd = '${workspaceFolder}',
      },
    }

    dap.configurations.gdscript = config
    dap.configurations.cs = config
    dap.configurations.lua = config
    dap.configurations.cpp = config

    if Print then
      print 'Isgodotproject is On'
    end
  else
    if Print then
      print 'Isgodotproject is Off'
    end
  end
end

local Isgodotproject = false
vim.api.nvim_create_user_command('GodotProject', function()
  Isgodotproject = not Isgodotproject
  SetGodotMode(Isgodotproject, true)
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

    dap.adapters.godot = {
      type = "server",
      host = '127.0.0.1',
      port = 6006,
    }

    local function file_exists(file)
      local f = io.open(file, "rb")
      if f then f:close() end
      return f ~= nil
    end
    --TODO check if inside of godot project
    SetGodotMode(file_exists("project.godot"), false)

    -- Basic debugging keymaps, feel free to change to your liking!
    --vim.keymap.set('n', '<leader>dl', dap.continue, { desc = 'Debug: Start/Continue' })
    local function string_starts(String, Start)
      return string.sub(String, 1, string.len(Start)) == Start
    end
    local function revlovepath(Path)
      if string_starts(Path, "~/") then
        Path = Path:sub(3)
        Path = os.getenv("HOME") .. "/" .. Path
      end
      return Path
    end

    vim.keymap.set('n', '<leader>dl', function()
      --- Some like
      --- ~/projectdir
      --- echo sometingcool
      --- exit 0

      local prestartfilepath = os.getenv("HOME") .. "/.nvim.prestart"

      if file_exists(prestartfilepath) then
        local commandworked = true
        local found = false

        local currentworkingdir = vim.fn.getcwd()
        local isreadingcommands = false
        local runonexit = false

        local commandstorun = ""
        for line in io.lines(prestartfilepath) do
          if isreadingcommands == false then
            if revlovepath(line) == currentworkingdir then
              runonexit = true
            end

            isreadingcommands = true
          else
            if string_starts(line, "exit") then
              isreadingcommands = false

              if runonexit then
                local commandtorun = commandstorun .. ":"

                found = true
                local job = vim.fn.jobstart(commandtorun, {
                  on_stdout = function(_, data, _)
                    if data then
                      for _, line in ipairs(data) do
                        print(line) -- Print output to command line
                      end
                    end
                  end,
                  on_stderr = function(_, data, _)
                    if data then
                      for _, line in ipairs(data) do
                        print("Error: " .. line) -- Print errors to command line
                      end
                    end
                  end,
                  on_exit = function(_, code)
                    print("Job finished with exit code: " .. code)
                    if code == 0 then
                      dap.continue()
                    end
                  end,
                })

                break;
              end
            else
              if runonexit then
                commandstorun = line .. " && "
              end
            end

            isreadingcommands = true
          end
          if found == false then
            dap.continue()
          end
        end
      else
        dap.continue()
      end
    end, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>dx', dap.disconnect, { desc = 'Debug: Close/Stop Debugging' })
    vim.keymap.set('n', '<leader>dp', dap.pause, { desc = 'Debug: Pause' })

    vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = 'Debug: Run to cursor' })
    vim.keymap.set('n', '<leader>dy', dap.goto_, { desc = 'Debug: Set Next Statement' })

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
      mappings = {
        edit = "e",
        expand = { "<CR>", "i" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
      },
      layouts = { {
        elements = { {
          id = "scopes",
          size = 1 / 3
        }, {
          id = "breakpoints",
          size = 1 / 3
        }, {
          id = "stacks",
          size = 1 / 3
        },
          -- {
          --   id = "watches",
          --   size = 0.25
          -- }
        },
        position = "left",
        size = 40
      }, {
        elements = {
          --  {
          --   id = "repl",
          --   size = 0.5
          -- },
          {
            id = "console",
            size = 1
          } },
        position = "bottom",
        size = 10
      } },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader>dt', dapui.toggle, { desc = 'Debug: See last session result.' })

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
