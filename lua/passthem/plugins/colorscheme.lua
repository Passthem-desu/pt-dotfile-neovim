--->
---> 主题定义
--->

-- One Dark
-- 见 https://github.com/navarasu/onedark.nvim
-- 在 README 上面有一些设置

local THEME_ONEDARK = {
    "navarasu/onedark.nvim",
    config = function()
        require('onedark').setup {
            transparent = true,
        }
        require('onedark').load()
    end
}


--- 以下才是正式生效的主题

return THEME_ONEDARK
