- Add breakpoint indicator behind the git signs
- There is number on some lines behind the git signs, remove that
- Check why phptools LSP doesn't run at all.
- Check where the hell did LspRestart and LspInfo command went
- Fix the below error:

vim.schedule callback: /usr/share/nvim/runtime/lua/vim/treesitter.lua:196: attempt to call method 'range' (a nil value)
stack traceback:
/usr/share/nvim/runtime/lua/vim/treesitter.lua:196: in function 'get_range'
/usr/share/nvim/runtime/lua/vim/treesitter.lua:231: in function 'get_node_text'
...nvim-treesitter/lua/nvim-treesitter/query_predicates.lua:141: in function 'handler'
/usr/share/nvim/runtime/lua/vim/treesitter/query.lua:868: in function '\_apply_directives'
/usr/share/nvim/runtime/lua/vim/treesitter/query.lua:1089: in function '(for generator)'
/usr/share/nvim/runtime/lua/vim/treesitter/languagetree.lua:1123: in function '\_get_injections'
/usr/share/nvim/runtime/lua/vim/treesitter/languagetree.lua:690: in function '\_parse'
/usr/share/nvim/runtime/lua/vim/treesitter/languagetree.lua:639: in function 'parse'
...ender-markdown.nvim/lua/render-markdown/request/view.lua:62: in function 'parse'
...azy/render-markdown.nvim/lua/render-markdown/core/ui.lua:156: in function 'parse'
...azy/render-markdown.nvim/lua/render-markdown/core/ui.lua:129: in function 'render'
...azy/render-markdown.nvim/lua/render-markdown/core/ui.lua:112: in function 'run'
...azy/render-markdown.nvim/lua/render-markdown/core/ui.lua:78: in function <...azy/render-markdown.nvim/lua/render-markdown/core/ui.lua:77>
