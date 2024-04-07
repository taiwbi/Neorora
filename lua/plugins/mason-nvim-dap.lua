return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    handlers = {
      -- PHP Adapter
      php = function(source_name)
        local dap = require "dap"
        ---@diagnostic disable-next-line: missing-fields
        dap.adapters.php = {
          type = "executable",
          command = "node",
          args = {
            "$HOME/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js",
          },
        }
        dap.adapters.codelldb = {
          type = "server",
          port = "13123",
          executable = {
            command = "$HOME/.local/share/nvim/mason/packages/codelldb/codelldb",
            args = { "--port", "13123" },
          },
        }
        dap.configurations.php = {
          {
            type = "php",
            request = "launch",
            name = "Listen for Xdebug",
            port = "9003",
          },
          {
            name = "Launch currently open script",
            type = "php",
            request = "launch",
            program = "${file}",
            cwd = "${fileDirname}",
            port = 0,
            runtimeArgs = { "-dxdebug.start_with_request=yes" },
            env = {
              XDEBUG_MODE = "debug,develop",
              XDEBUG_CONFIG = "client_port=${port}",
            },
          },
          -- If you want to have some configurations that you don't want to track in git, you can uncomment the below line and return your configurations in ./dap-php.lua file
          -- require "user.plugins.config.dap-php", -- Personal PHP debug configurations
        }
        dap.configurations.rust = {
          {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            sourceLanguages = { "rust" },
          },
        }
      end,
      -- Python
      python = function(source_name)
        local dap = require "dap"
        dap.adapters.python = function(cb, config)
          if config.request == "attach" then
            ---@diagnostic disable-next-line: undefined-field
            local port = (config.connect or config).port
            ---@diagnostic disable-next-line: undefined-field
            local host = (config.connect or config).host or "127.0.0.1"
            ---@diagnostic disable-next-line: missing-fields
            cb {
              type = "server",
              port = assert(port, "`connect.port` is required for a python `attach` configuration"),
              host = host,
              options = {
                source_filetype = "python",
              },
            }
          else
            ---@diagnostic disable-next-line: missing-fields
            cb {
              type = "executable",
              command = "/usr/bin/python",
              args = { "-m", "debugpy.adapter" },
              options = {
                source_filetype = "python",
              },
            }
          end
        end
        dap.configurations.python = {
          {
            type = "python",
            request = "launch",
            name = "Launch file",

            program = "${file}",
            pythonPath = function()
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
              elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
              else
                return "/usr/bin/python"
              end
            end,
            console = "integratedTerminal", -- This line will prevent EOF error on input() function
          },
        }
      end,
    },
  },
}
