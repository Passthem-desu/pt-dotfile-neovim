-- 这里 prettierd 是一个 Daemon 程序，如果配置了 prettierd 作为 Formatter，那么
-- 就会用 prettierd
local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            javascript = prettier,
            typescript = prettier,
            javascriptreact = prettier,
            typescriptreact = prettier,

            vue = prettier,
            svelte = prettier,
            astro = prettier,

            css = prettier,
            scss = prettier,
            less = prettier,
            postcss = prettier,

            html = prettier,
            json = prettier,
            jsonc = prettier,
            yaml = prettier,
            markdown = prettier,
            ["markdown.mdx"] = prettier,
            graphql = prettier,

            rust = { 'rustfmt' },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = false,
    },
}
