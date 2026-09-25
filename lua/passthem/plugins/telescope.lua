return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "andrew-george/telescope-themes",
    },
    config = function ()
        require('telescope').setup {
            defaults = {
                initial_mode = "normal",
            },
            pickers = {},
        }

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = '查找 Buffers' })
        vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = '在所有文件搜索' })
        vim.keymap.set('n', '<leader>ph', builtin.help_tags, { desc = 'NeoVim 帮助' })
        vim.keymap.set('n', '<leader>pm', function ()
            builtin.man_pages({
                sections = { "ALL" }
            })
        end, { desc = '搜索 Manpage' })
        vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'git status' })
        vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'git branch' })
        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '查找文件' })
        vim.keymap.set('n', '<leader>pk', builtin.keymaps, { desc = '查找键位' })
    end
}
