-- Customize Treesitter

---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"sql",
			"bash",
			"html",
			"css",
			"javascript",
			"php",
			"blade",
			"scss",
			"python",
			"rust",
			"hyprlang",
			"diff",
			"xml",
		},
	},
}
