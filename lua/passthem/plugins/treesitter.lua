return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "typst",
                "latex",
                "yaml",
            },
            auto_install = true,
        },
        config = function(_, opts)
            require("nvim-treesitter").setup(opts)

            -- 配置缩进使用 treesitter 的
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.treesitter.language.register("markdown", "mdx")

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    }
}
