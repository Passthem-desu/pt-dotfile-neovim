if true then
    return {
        'nvim-lualine/lualine.nvim',

        -- 状态栏晚一帧出现，避免占用启动时间
        event = "VeryLazy",

        config = function()
            local lualine = require("lualine")
            lualine.setup({
                options = {
                    icons_enabled = false,
                    component_separators = {
                        left  = '|',
                        right = '|',
                    },
                    section_separators = {
                        left  = '',
                        right = '',
                    },
                    -- globalstatus = true,
                },
            })
        end,
    }
else
    return {}
end
