return {
    { -- 用于方便创建和删除括号包裹
        "nvim-mini/mini.surround",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            custom_surroundings = {
                ['('] = { output = { left = '(', right = ')' } },
                ['['] = { output = { left = '[', right = ']' } },
                ['{'] = { output = { left = '{', right = '}' } },
                ['<'] = { output = { left = '<', right = '>' } },
            },
            highlight_duration = 200,
            mappings = {
                add            = '<leader>sa',
                delete         = '<leader>sd',
                find           = '<leader>sf', -- Find surrounding (to the right)
                find_left      = '<leader>sF', -- Find surrounding (to the left)
                highlight      = '<leader>sh', -- Highlight surrounding
                replace        = '<leader>sr', -- Replace surrounding
                update_n_lines = '<leader>sn', -- Update `n_lines`

                -- suffix_last = 'l',     -- Suffix to search with "prev" method
                -- suffix_next = 'n',     -- Suffix to search with "next" method
            },
            n_lines = 20,
            respect_selection_type = false,
            search_method = 'cover',
            silent = false,
        },
    },
    { -- 提醒行末空格
        "nvim-mini/mini.trailspace",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local mini_trailspace = require("mini.trailspace")

            mini_trailspace.setup({
                only_in_normal_buffers = true,
            })
        end
    },
    { -- 把东西在单行和多行之间切换
        "nvim-mini/mini.splitjoin",
        config = function()
            local mini_splitjoin = require("mini.splitjoin")

            -- 禁用默认键位
            mini_splitjoin.setup({
                mappings = { toggle = "" },
            })

            vim.keymap.set(
                { "n", "x", },
                "<leader>sj",
                function() mini_splitjoin.join() end,
                { desc = "合并多行" }
            )
            vim.keymap.set(
                { "n", "x", },
                "<leader>sk",
                function() mini_splitjoin.split() end,
                { desc = "展开多行" }
            )
        end
    },
    {
        "nvim-mini/mini.cursorword",
        config = function()
            require('mini.cursorword').setup()
        end
    },
    {
        "nvim-mini/mini.align",
        config = function()
            require('mini.align').setup()
        end
    },
}
