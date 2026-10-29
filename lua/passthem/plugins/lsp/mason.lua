-- mason 的 `setup()` 在文件系统操作慢的机器上有约 0.8s 的固定开销（Windows 上实测
-- 1.2s 含依赖链）。本配置的 LSP 是由 vim.lsp.enable() 原生启用的，不依赖
-- mason-lspconfig 的自动启用，所以把 mason 改为按命令懒加载；但它的 bin 目录必须手动
-- 挂到 PATH 上，否则 vim.lsp 解析不到 mason 安装的可执行文件。
vim.env.PATH = table.concat({
	vim.fn.stdpath("data") .. "/mason/bin",
	vim.env.PATH,
}, vim.fn.has("win32") == 1 and ";" or ":")

return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
		"saghen/blink.cmp",
	},
	cmd = {
		"Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll",
		"MasonUpdate", "MasonLog",
		"MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()
	end,
}
