vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    [".foorc"] = "fooscript",
  },
  pattern = {
    [".*/etc/foo/.*"] = "fooscript",
    [".*/ghostty/config"] = "toml",
    [".*/vscode/.*.json"] = "jsonc",
    [".*%.blade%.php"] = "blade",
  },
}
