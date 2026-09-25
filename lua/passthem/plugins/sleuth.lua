-- 根据文件内容自动设置 `shiftwidth`, `expandtab` 等字段

return {
    "tpope/vim-sleuth",
    config = function()
        -- 在文件保存的时候，自动让 Sleuth 插件重新探测一次缩进模式
        vim.api.nvim_create_autocmd("BufWritePost", {
            callback = function()
                pcall(function()
                    vim.cmd("silent! Sleuth")
                end)
            end
        })
    end
}
