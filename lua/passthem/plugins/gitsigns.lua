-- 在 NeoVim 显示 Git 的编辑
return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        sign_priority = 110,
    },
}
