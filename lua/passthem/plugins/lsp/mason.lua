return {
    "mason-org/mason.nvim",
    lazy = false,
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "neovim/nvim-lspconfig",
        "saghen/blink.cmp",
    },
    config = function()
        -- import mason and mason_lspconfig
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup()

        mason_lspconfig.setup({
            ensure_installed = {
                -- lua
                "lua-ls",

                -- python
                "ruff",
                "basedpyright",

                -- rust
                "rust_analyzer",

                -- golang
                "gopls",

                -- c/c++
                "clangd",

                -- web
                "svelte",
                "tailwindcss",
                "astro",

                -- misc
                "just",
                "dockerls",
                "docker_compose_language_service",
                "taplo",  -- toml 支持
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
            },
        })
    end,
}
