return {
    "windwp/nvim-ts-autotag",
    ft = {
        "html", "javascript", "typescript",
        "javascriptreact", "typescriptreact",
        "vue", "svelte", "xml", "php",
    },
    config = function()
        require('nvim-ts-autotag').setup({
            opts = {
                enable_close = true,  -- 自动闭合
                enable_rename = true, -- 同步修改
                enable_close_on_slash = true, -- 输入 / 自动闭合
            },
        })
    end,
}
