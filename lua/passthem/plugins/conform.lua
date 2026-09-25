-- 优先使用常驻 daemon prettierd，格式化速度更快；
-- 找不到时回退到 CLI prettier。stop_after_first 保证只运行命中的第一个，
-- 否则 conform 会把两者都跑一遍。
local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            -- 基础脚本 (Base Scripts)
            javascript = prettier,
            typescript = prettier,
            javascriptreact = prettier,
            typescriptreact = prettier,

            -- 框架组件 (Framework Components)
            vue = prettier,
            svelte = prettier,
            astro = prettier,

            -- 样式表 (Stylesheets)
            css = prettier,
            scss = prettier,
            less = prettier,
            postcss = prettier,

            -- 标记语言与配置 (Markup & Configs)
            html = prettier,
            json = prettier,
            jsonc = prettier, -- 带注释的 JSON (JSON with Comments)
            yaml = prettier,
            markdown = prettier,
            ["markdown.mdx"] = prettier,
            graphql = prettier,
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = false, -- 强制不使用 LSP，只信赖 Prettier
        },
    },
}
