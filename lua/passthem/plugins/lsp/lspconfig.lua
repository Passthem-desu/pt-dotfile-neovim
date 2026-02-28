return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        "saghen/blink.cmp",
    },
    config = function()
        -- NOTE: LSP Keybinds
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings
                local opts = { buffer = ev.buf, silent = true }

                -- Keymaps
                -- opts.desc = "查看 LSP 引用"
                -- vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "查看 LSP 引用"
                vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "前往 LSP 定义"
                vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)

                opts.desc = "查看 LSP 定义"
                vim.keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "查看 LSP 实现"
                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "查看 LSP 类型定义"
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                opts.desc = "查看可用的代码操作"
                vim.keymap.set({ "n", "v" }, "<leader>ca", function()
                    vim.lsp.buf.code_action()
                end, opts)

                opts.desc = "重命名变量"
                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

                opts.desc = "查看当前文件的代码诊断"
                vim.keymap.set("n", "<leader>cD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "查看当前行代码诊断"
                vim.keymap.set("n", "<leader>cd", function()
                    vim.diagnostic.open_float({ focusable = true, })
                end, opts)

                opts.desc = "查看当前选中项的定义"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "重启 LSP 服务器"
                vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", opts)

                -- vim.keymap.set("i", "<C-h>", function()
                --     vim.lsp.buf.signature_help()
                -- end, opts)
            end,
        })

        -- NOTE: Diagnostic Setup
        -- Define sign icons for each severity
        local signs = {
            [vim.diagnostic.severity.ERROR] = "x ",
            [vim.diagnostic.severity.WARN] = "! ",
            [vim.diagnostic.severity.HINT] = "* ",
            [vim.diagnostic.severity.INFO] = "i ",
        }

        -- curosr hover hold
        local augroup = vim.api.nvim_create_augroup("LspDiagnosticsHold", { clear = true })
        local virtual_text_enabled = true
        vim.o.updatetime = 350

        -- helper functon check if cursor over diagnostic
        local function cursor_over_diagnostic()
            local bufnr = vim.api.nvim_get_current_buf()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            local lnum = cursor_pos[1] - 1
            local col = cursor_pos[2]
            local diags = vim.diagnostic.get(bufnr, { lnum = lnum })
            for _, diag in ipairs(diags) do
                if diag.end_lnum == lnum and col >= diag.col and col < diag.end_col then
                    return true
                end
            end
            return false
        end

        -- helper check for any open float (to avoid overlaps with float doc)
        local function has_floating_win()
            for _, winid in ipairs(vim.api.nvim_list_wins()) do
                local cfg = vim.api.nvim_win_get_config(winid)
                if cfg.relative ~= '' then
                    return true
                end
            end
            return false
        end

        -- update diagnostic config function
        local function update_diagnostic_config()
            vim.diagnostic.config({
                signs = { text = signs },
                virtual_text = virtual_text_enabled,
                underline = true, -- Always on
                update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = true,
                },
            })
        end

        -- call initial diagnostic setup
        update_diagnostic_config()

        -- LSP Toggle Keymaps
        -- <leader>lx toggle for virtual text (no hover changes)
        vim.keymap.set('n', '<leader>lx', function()
            virtual_text_enabled = not virtual_text_enabled
            update_diagnostic_config()
        end, { desc = "切换显示 LSP 诊断" })

        -- <leader>ll toggle between virtual text mode and precise hover mode
        vim.keymap.set('n', '<leader>ll', function()
            virtual_text_enabled = not virtual_text_enabled
            update_diagnostic_config()

            -- Clear autocmds first
            vim.api.nvim_clear_autocmds({ group = augroup })

            -- Enable hover only when virtual text is off
            if not virtual_text_enabled then
                vim.api.nvim_create_autocmd("CursorHold", {
                    group = augroup,
                    callback = function()
                        if cursor_over_diagnostic() and not has_floating_win() then
                            vim.diagnostic.open_float(nil, {
                                focusable = false,
                                close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave" },
                            })
                        end
                    end,
                })
            end
        end, { desc = "Toggle LSP diagnostics virtual text or precise hover" })

        vim.keymap.set('n', '<leader>lh', function ()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "切换显示类型推断提示" })

        -- NOTE: Setup servers
        -- local cmp_nvim_lsp = require("cmp_nvim_lsp")
        -- local capabilities = cmp_nvim_lsp.default_capabilities()
        local capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true
            }
          }
        }
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

        -- Global LSP settings (applied to all servers)
        vim.lsp.config('*', {
            capabilities = capabilities,
        })
    end,
}
