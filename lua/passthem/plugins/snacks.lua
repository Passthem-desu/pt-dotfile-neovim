-- https://github.com/folke/snacks.nvim
-- 这个插件是一大堆功能的功能集合插件
-- 或许有很多有用功能吧，感觉要看它的 Github 最好

return {
    {
        "folke/snacks.nvim",
        priority = 1000,

        -- 一启动就加载
        lazy = false,

        ---@type snacks.Config
        opts = {
            picker = {
                enabled = true,
                matchers = {
                    frecency = true,
                },
            },
        },

        keys = {
            { -- Lazygit
                "<leader>gg",
                function()
                    require("snacks").lazygit()
                end,
                desc = "打开 LazyGit 窗口",
            },
            { -- Git Branch
                "<leader>gb",
                function()
                    require("snacks")
                        .picker
                        .git_branches({ layout = "select" })
                end,
                desc = "选择并切换 git 分支"
            },
            {
                "<leader>pf",
                function()
                    require("snacks").picker.files()
                end,
                desc = "查找文件",
            },
            {
                "<leader>pk",
                function()
                    require("snacks").picker.keymaps({ layout = "ivy" })
                end,
                desc = "查看键位配置",
            },
            {
                "<leader>vh",
                function()
                    require("snacks").picker.help()
                end,
                desc = "查看 NeoVim 文档",
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { -- 查询代办
                "<leader>pt",
                function()
                    require("snacks").picker.todo_comments()
                end,
                desc = "查找代办",
            },
        },
    },
}
