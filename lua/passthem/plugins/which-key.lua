return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300 -- 弹出延迟时间（毫秒）
    end,
    config = function()
        local wk = require("which-key")

        wk.add({ "<leader>p", group = "查找" })
        wk.add({ "<leader>w", group = "窗口" })
        wk.add({ "<leader>b", group = "标签页" })
        wk.add({ "<leader>s", group = "mini.nvim" })
        wk.add({ "<leader>g", group = "git" })
        wk.add({ "<leader>v", group = "vim" })
        wk.add({ "<leader>c", group = "代码" })
        wk.add({ "<leader>e", group = "文件管理" })
    end,
    opts = {},
}
