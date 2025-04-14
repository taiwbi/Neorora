return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    handlers = {
      php = function(source_name)
        local dap = require "dap"
        dap.adapters.php = {
          type = "executable",
          command = "node",
          args = {
            os.getenv "HOME" .. "/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js",
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
        }
      end,
    },
  },
}
