-- 在 NeoVim 显示 Git 的编辑
return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        sign_priority = 110,
        on_attach = function(bufnr)
            local gs = require("gitsigns")

            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, {
                    buffer = bufnr,
                    silent = true,
                    desc = desc,
                })
            end

            local function hunk_range()
                local mode = vim.fn.mode()
                if mode == "v" or mode == "V" or mode == "\22" then
                    local a, b = vim.fn.line("v"), vim.fn.line(".")
                    return { math.min(a, b), math.max(a, b) }
                end
            end

            local function with_range(fn)
                return function()
                    fn(hunk_range())
                end
            end

            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gs.nav_hunk("next")
                end
            end, "下一个 hunk")

            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gs.nav_hunk("prev")
                end
            end, "上一个 hunk")

            map({ "o", "x" }, "ih", gs.select_hunk, "选择 hunk")

            map({ "n", "x" }, "<leader>ga", with_range(gs.stage_hunk), "暂存 hunk")
            map("n", "<leader>gA", gs.stage_buffer, "暂存整个 buffer")
            map({ "n", "x" }, "<leader>gr", with_range(gs.reset_hunk), "丢弃 hunk")
            map("n", "<leader>gR", gs.reset_buffer, "丢弃整个 buffer 的改动")
            map("n", "<leader>gp", gs.preview_hunk, "预览 hunk")
            map("n", "<leader>gd", gs.diffthis, "对比暂存区")
            map("n", "<leader>gl", function()
                gs.blame_line({ full = true })
            end, "查看当前行 blame")
            map("n", "<leader>gq", gs.setqflist, "当前 buffer 的 hunk 进 quickfix")
            map("n", "<leader>gQ", function()
                gs.setqflist("all")
            end, "全仓库的 hunk 进 quickfix")
        end,
    },
}
