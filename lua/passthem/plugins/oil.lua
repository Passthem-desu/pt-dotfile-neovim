return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },

        config = function()
            require("oil").setup({
                default_file_explorer = true, -- 设置成默认文件管理器
                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime",
                },
                keymaps = {
                    ["<C-h>"] = false,
                    ["<C-c>"] = false, -- prevent from closing Oil as <C-c> is esc key
                    ["<M-h>"] = "actions.select_split",
                    ["q"] = "actions.close",
                },
                delete_to_trash = false,
                view_options = {
                    show_hidden = true,
                },
                skip_confirm_for_simple_edits = true,
                win_options = {
                    signcolumn = "yes:2",
                },
            })

            -- opens parent dir over current active window
            vim.keymap.set("n", "<leader>eo", "<CMD>Oil<CR>", { desc = "打开 Oil 文件管理器" })
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "打开 Oil 文件管理器" })
        end,
    },
    {
        "refractalize/oil-git-status.nvim",
        dependencies = { "stevearc/oil.nvim", },

        config = function ()
            require("oil-git-status").setup({
                show_ignored = true,
                symbols = {
                    index = {
                        ["!"] = "i"
                    },
                    working_tree = {
                        ["!"] = "i"
                    },
                }
            })
        end,
    },
    {
        "JezerM/oil-lsp-diagnostics.nvim",
        dependencies = { "stevearc/oil.nvim" },
        opts = {},
    },
}
