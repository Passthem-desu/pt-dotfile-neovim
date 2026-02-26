return {
    "windwp/nvim-ts-autotag",
    config = function()
        require('nvim-ts-autotag').setup({
            opts = {
                enable_close = true,  -- 自动闭合
                enable_rename = true, -- 同步修改
                enable_close_on_slash = true, -- 输入 / 自动闭合
            },
        })
    end,
    ft = {
        "html", "javascript", "typescript", "javascriptreact",
        "typescriptreact", "svelte", "vue", "xml", "astro"  -- 加上这个
    },
}
