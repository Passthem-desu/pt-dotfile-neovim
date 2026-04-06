return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            -- 基础脚本 (Base Scripts)
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },

            -- 框架组件 (Framework Components)
            vue = { "prettier" },
            svelte = { "prettier" },
            astro = { "prettier" },

            -- 样式表 (Stylesheets)
            css = { "prettier" },
            scss = { "prettier" },
            less = { "prettier" },
            postcss = { "prettier" },

            -- 标记语言与配置 (Markup & Configs)
            html = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" }, -- 带注释的 JSON (JSON with Comments)
            yaml = { "prettier" },
            markdown = { "prettier" },
            ["markdown.mdx"] = { "prettier" },
            graphql = { "prettier" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = false, -- 强制不使用 LSP，只信赖 Prettier
        },
    },
}
