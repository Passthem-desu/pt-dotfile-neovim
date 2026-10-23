local function setup_local_lsp()
    -- GDScript
    vim.lsp.config('godot', {
        name = 'Godot',
        cmd = { 'nc', '127.0.0.1', '6005' },
        root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
    })

    -- Nushell
    if vim.fn.executable("nu") == 1 then
        vim.lsp.config("nu_lsp", {
            cmd = { "nu", "--lsp" },
            filetypes = { "nu" },
            root_markers = { ".git" },
        })
        vim.lsp.enable("nu_lsp")
    end

    -- nix
    if vim.fn.executable("nixd") == 1 then
        vim.lsp.enable('nixd')
        if vim.fn.executable("nixfmt") ~= 1 then
            vim.notify("注意：nixfmt 不在环境中", vim.log.levels.WARN)
        end
    end

    -- Golang
    if vim.fn.executable("gopls") == 1 then
        vim.lsp.enable('gopls')
    end

    -- Typescript
    if vim.fn.executable("typescript-language-server") == 1 then
        vim.lsp.enable('ts_ls')
    end

    -- Python
    if vim.fn.executable("ruff") == 1 then
        vim.lsp.enable('ruff')
    end
    if vim.fn.executable("basedpyright") == 1 then
        vim.lsp.enable('basedpyright')
    end

    -- Rust
    if vim.fn.executable('rust-analyzer') == 1 then
        vim.lsp.config('rust_analyzer', {
            settings = {
                ['rust-analyzer'] = {
                    check = {
                        command = "clippy",
                    },
                },
            },
        })
        vim.lsp.enable('rust_analyzer')
    end

    -- Clangd
    if vim.fn.executable('clangd') == 1 then
        vim.lsp.enable('clangd')
    end

    -- Justfile
    if vim.fn.executable('just-lsp') == 1 then
        vim.lsp.enable('just')
    end

    -- Typst
    if vim.fn.executable('tinymist') == 1 then
        vim.lsp.enable('tinymist')
    end
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

        -- update diagnostic config function
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "x ",
                    [vim.diagnostic.severity.WARN] = "! ",
                    [vim.diagnostic.severity.HINT] = "* ",
                    [vim.diagnostic.severity.INFO] = "i ",
                }
            },
            virtual_text = true,
            underline = true,
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "solid",
                source = true,
            },
        })

        vim.keymap.set("n", "<leader>lh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "切换显示类型推断提示" })

        configure_lsp()
        setup_local_lsp()
    end,
}
