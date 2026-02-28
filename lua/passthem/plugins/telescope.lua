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
            defaults = {}
        }

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = '查找 Buffers' })
        vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = '在所有文件搜索' })
    end
}
