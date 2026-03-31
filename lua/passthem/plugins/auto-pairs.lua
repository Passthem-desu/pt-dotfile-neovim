-- https://github.com/Sin-cy/dotfiles/blob/main/nvim/.config/nvim/lua/sethy/plugins/auto-pairs.lua
-- 用于括号匹配

return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local autopairs = require("nvim-autopairs") -- import nvim-autopairs
        local Rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")

        -- setup autopairs
        autopairs.setup({
            check_ts = true,        -- treesitter enabled
            ts_config = {
                lua = { "string" }, -- dont add pairs in lua string treesitter nodes
                -- javascript = { "template_string" }, -- dont add pairs in javscript template_string treesitter nodes
                java = false,       -- dont check treesitter on java
            },
        })

        -- 配置在 Typst 配对美元符号的能力
        autopairs.add_rules({
            Rule("$", "$", "typst")
                :with_pair(function(opts)
                    return opts.line:sub(opts.col - 1, opts.col - 1) ~= [[\]]
                end)
                :with_move(function(opts)
                    return opts.char == "$"
                end)
                :with_cr(cond.none())
        })

        -- import nvim-autopairs completion functionality
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        -- import nvim-cmp plugin (completions plugin)
        local cmp = require("cmp")
        -- make autopairs and completion work together
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
