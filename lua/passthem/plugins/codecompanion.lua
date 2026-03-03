return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local adapters = {}
        local default_adapter = "bailian"

        local status, apikeys = pcall(require, "passthem.secrets.apikeys")
        if not status then
            vim.notify("当前环境没有创建 apikeys.lua 文件", vim.log.levels.WARN)
            apikeys = {}
        end

        -- 配置 AI 模型
        -- Kiroswitch API，求不要倒下，这是我接触最新最热 AI 的唯一途径，，，
        if apikeys.kiroswitch then
            -- default_adapter = "kiroswitch"
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

        -- 百炼大模型，我没有买 Coding 方案，好贵
        if apikeys.bailian then
            adapters.bailian = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        api_key = function()
                            return apikeys.bailian
                        end,
                    },
                    name = "bailian",
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
