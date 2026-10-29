local function setup_local_lsp()
    -- -- GDScript
    -- vim.lsp.config('godot', {
    --     name = 'Godot',
    --     cmd = { 'nc', '127.0.0.1', '6005' },
    --     root_dir = vim.fs.dirname(
    --         vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]
    --     ),
    -- })

    vim.lsp.enable({
        'nu_lsp', 'nixd', 'gopls', 'ts_ls', 'ruff', 'basedpyright', 'godot',
        'rust_analyzer', 'clangd', 'just', 'tinymist', 'astro', 'eslint',
        'eslint_d', 'dockerls', 'docker_compose_language_service', 'svelte',
        'tailwindcss', 'vue_ls', 'wgsl_analyzer', 'yamlls', 'taplo',
        'systemd_lsp', 'lua_ls', 'neocmake',
    })
end

local function configure_lsp()
    -- 获取默认的 LSP 能力
    local capabilities = require("blink.cmp").get_lsp_capabilities({
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
        },
    })

    -- Global LSP settings (applied to all servers)
    vim.lsp.config("*", {
        capabilities = capabilities,
    })

    vim.lsp.config("tinymist", {
        formatterMode = "typstyle",
        exportPDF = "onType",
        semanticTokens = "disable",
    })

    vim.lsp.config('vtsls', {
        filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' },
        settings = {
            vtsls = {
                tsserver = {
                    globalPlugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vim.fn.stdpath("data")
                                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                            languages = { "vue" },
                            configNamespace = "typescript",
                        },
                    },
                },
            },
        },
    })

    -- Rust
    vim.lsp.config('rust_analyzer', {
        settings = {
            ['rust-analyzer'] = {
                check = {
                    command = "clippy",
                },
            },
        },
    })

    -- Nushell
    vim.lsp.config("nu_lsp", {
        cmd = { "nu", "--lsp" },
        filetypes = { "nu" },
        root_markers = { ".git" },
    })
end

local function diagnostic_utils()
    -- 这个闭包用来提供一个状态机，供外界使用

    local virtual_text = false
    local underline = true

    -- 设置初始状态
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "x ",
                [vim.diagnostic.severity.WARN] = "! ",
                [vim.diagnostic.severity.HINT] = "* ",
                [vim.diagnostic.severity.INFO] = "i ",
            }
        },
        virtual_text = virtual_text,
        underline = underline,
        update_in_insert = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "solid",
            source = true,
        },
    })

    return {
        toggle_virtual_text = function ()
            virtual_text = not virtual_text
            vim.diagnostic.config({
                virtual_text = virtual_text,
            })
        end,
        toggle_underline = function ()
            underline = not underline
            vim.diagnostic.config({
                underline = underline,
            })
        end,
    }
end

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

                opts.desc = "查看定义"
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "查看当前文件的代码诊断"
                vim.keymap.set("n", "<leader>cD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "查看可用的代码操作"
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "查看声明"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "查看引用"
                vim.keymap.set("n", "<leader>cr", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "重命名变量"
                vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, opts)

                opts.desc = "查看当前行代码诊断"
                vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts)
            end,
        })

        local utils = diagnostic_utils()

        vim.keymap.set("n", "<leader>lh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "类型标签" })
        vim.keymap.set("n", "<leader>ll", function ()
            utils.toggle_virtual_text()
        end, { desc = "行内错误标注" })
        vim.keymap.set("n", "<leader>lu", function ()
            utils.toggle_underline()
        end, { desc = "下划线" })

        configure_lsp()
        setup_local_lsp()
    end,
}
