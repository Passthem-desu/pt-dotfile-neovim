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
                options = {
                    parsers = {
                        css = true,
                        tailwind = { enable = true },
                    },
                },
            })

            tailwindcolorizer.setup({
                color_square_width = 2,
            })

        end,
    },
}
