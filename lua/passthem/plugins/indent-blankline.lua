return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
            -- 普通空格缩进使用的字符
            char = "┊",
            -- Tab 字符使用的专属字符（开启后可一眼区分 Tab 与空格）
            tab_char = "⇥",
        },
        whitespace = {
            -- 是否高亮尾部多余的空格
            highlight = { "Whitespace", "NonText" },
        },
    },
}
