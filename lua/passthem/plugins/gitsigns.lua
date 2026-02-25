return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            -- Navigation
            map("n", "]h", gs.next_hunk, "下一个 git 编辑")
            map("n", "[h", gs.prev_hunk, "上一个 git 编辑")

            -- Actions
            map("n", "<leader>gs", gs.stage_hunk, "git 暂存编辑块")
            map("n", "<leader>gr", gs.reset_hunk, "git 重置编辑块")

            map("v", "<leader>gs", function() -- stage selected hunk
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "git 暂存选中")
            map("v", "<leader>gr", function() -- reset selected hunk
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "git 重置选中")

            map("n", "<leader>gS", gs.stage_buffer, "git 暂存文件") -- stage whole buffer
            map("n", "<leader>gR", gs.reset_buffer, "git 重置文件") -- unstage whole buffer
            map("n", "<leader>gu", gs.undo_stage_hunk, "git 撤销编辑块")
            map("n", "<leader>gp", gs.preview_hunk, "git 预览编辑块")
            map("n", "<leader>gl", function() gs.blame_line({ full = true }) end, "git 查看当前行编辑历史")
            map("n", "<leader>gB", gs.toggle_current_line_blame, "切换 git 历史")
            map("n", "<leader>gd", gs.diffthis, "git 查看 diff")
            map("n", "<leader>gD", function() gs.diffthis("~") end, "git 查看 diff ~")

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
        end,
    },
}
