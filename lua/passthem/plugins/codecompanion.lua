local function build_adapters()
    local adapters = {}
    local default_adapter = "bailian"

    local status, apikeys = pcall(require, "passthem.secrets.apikeys")
    if not status then
        apikeys = {}
    end

    if apikeys.kiroswitch then
        default_adapter = "kiroswitch"
        adapters.kiroswitch = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                    api_key = function()
                        return apikeys.kiroswitch
                    end,
                },
                name = "kiroswitch",
                url = "https://beta.kiroswitch.top/v1/chat/completions",
                schema = {
                    model = {
                        default = "claude-opus-4.6",
                        choices = {
                            "claude-opus-4.6",
                        },
                    },
                },
            })
        end
    end

    if apikeys.bailian then
        default_adapter = "bailian"
        adapters.bailian = function()
            return require("codecompanion.adapters").extend("deepseek", {
                env = {
                    api_key = function()
                        return apikeys.bailian
                    end,
                },
                name = "bailian",
                formatted_name = "千问",
                url = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
                schema = {
                    model = {
                        default = "qwen3.5-plus",
                        choices = {
                            ["qwen3.5-plus"] = { opts = { can_reason = true } },
                            "qwen3-max",
                        },
                    },
                },
            })
        end
    end

    if apikeys.minimax then
        default_adapter = "minimax"
        adapters.minimax = function()
            return require("codecompanion.adapters").extend("deepseek", {
                env = {
                    api_key = function()
                        return apikeys.minimax
                    end
                },
                name = "minimax",
                formatted_name = "Minimax Token Plan",
                url = "https://api.minimaxi.com/v1/chat/completions",
                schema = {
                    model = {
                        default = "MiniMax-M2.7",
                        choices = {
                            ["MiniMax-M2.7"] = { opts = { can_reason = true } }
                        },
                    }
                }
            })
        end
    end

    return adapters, default_adapter
end

local code_companion_config = {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local adapters, default_adapter = build_adapters()

        require("codecompanion").setup({
            adapters = {
                http = adapters,
            },
            strategies = {
                chat = {
                    adapter = default_adapter,
                },
            },
            interactions = {},
            opts = {
                language = "Chinese",
            },
        })
    end
}

return {
    code_companion_config,
}
