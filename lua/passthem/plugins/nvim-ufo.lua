local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 折叠了 %d 行 '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            table.insert(newVirtText, { chunkText, chunk[2] })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- 如果宽度不够，强行截断
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'Comment' })
    return newVirtText
end

return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = "VeryLazy",
    opts = {
        provider_selector = function(bufnr, filetype, buftype)
            return { 'lsp', 'indent' }
        end,
        fold_virt_text_handler = handler,
    },
    config = function(_, opts)
        -- 必要的设置：Neovim 的折叠参数
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- 使用 ufo 的设置
        require('ufo').setup(opts)

        -- 快捷键设置
        vim.keymap.set(
            'n',
            'zR',
            require('ufo').openAllFolds,
            { desc = "打开所有折叠" }
        )
        vim.keymap.set(
            'n',
            'zM',
            require('ufo').closeAllFolds,
            { desc = "关闭所有折叠" }
        )
    end,
}
