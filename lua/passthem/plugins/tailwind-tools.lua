-- 可以在前端项目使用的，查看各种颜色值的颜色

return {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    {
        "NvChad/nvim-colorizer.lua",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
        config = function()
            local nvchadcolorizer = require("colorizer")
            local tailwindcolorizer = require("tailwindcss-colorizer-cmp")

            nvchadcolorizer.setup({
                user_default_options = {
                    tailwind = true,
                },
                filetypes = {
                    "html",
                    "css",
                    "javascript",
                    "typescript",
                    "javascriptreact",
                    "typescriptreact",
                    "vue",
                    "svelte",
                    "astro",
                    "eslint",
                    "eslint_d"
                },
            })

            tailwindcolorizer.setup({
                color_square_width = 2,
            })

        end,
    },
}
