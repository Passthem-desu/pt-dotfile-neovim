if true then
    return {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },

        config = function()
            local lualine = require("lualine")
            lualine.setup({
                options = {
                    icons_enabled = false,
                },
            })
        end,
    }
else
    return {}
end
