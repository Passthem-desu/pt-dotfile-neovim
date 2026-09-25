-- https://github.com/Sin-cy/dotfiles/blob/main/nvim/.config/nvim/lua/sethy/plugins/auto-pairs.lua
-- 用于括号匹配

return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  opts = {
    check_ts = true,
    ts_config = {
      lua = { "string" },
      java = false,
    },
  },
  config = function(_, opts)
    local autopairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    autopairs.setup(opts)

    -- 配置在 Typst 配对美元符号的能力
    autopairs.add_rules({
      Rule("$", "$", "typst")
        :with_pair(function(opts_pair)
          return opts_pair.line:sub(opts_pair.col - 1, opts_pair.col - 1) ~= [[\]]
        end)
        :with_move(function(opts_move)
          return opts_move.char == "$"
        end)
        :with_cr(cond.none()),
    })
  end,
}
