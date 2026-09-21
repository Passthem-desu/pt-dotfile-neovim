local opts = { noremap = true, silent = true }

--->
---> Vim 自带内容
--->

-- <leader> 符号定义
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 在搜索时，自动将搜索词所在行居中
-- zz 用于将所在行居中，zv 用于展开足够多的展开项以显示搜索词
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- 缩进后，重新选中上一次的选区
-- 这样可以连续调整缩进
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- 在粘贴时，不替换剪切板
vim.keymap.set("v", "p", '"_dP', opts)

-- 用 Esc 清空搜索内容
vim.keymap.set("n", "<Esc>", ":nohl<CR>", {
    desc = "清空搜索内容",
    silent = true,
})

-- 禁用 Ex 模式
vim.keymap.set("n", "Q", "<nop>")

-- 用 x 删除内容不复制
vim.keymap.set("n", "x", '"_x', opts)

-- 高亮复制
vim.api.nvim_create_autocmd(
    "TextYankPost", -- 在复制文字时触发
    {
        desc = "在复制内容时高亮",

        -- 方便在 :autocmd 查看命令列表时知道它是干什么的
        group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),

        callback = function()
            vim.hl.on_yank({
                higroup = "IncSearch",
                timeout = 200,
            })
        end,
    }
)

--->
---> LSP 相关
--->

vim.keymap.set("n", "<leader>cf", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end, { desc = "格式化代码" })
vim.keymap.set("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "打开 Mason" })


--->
---> 文件管理
--->

vim.keymap.set("n", "<leader>en", "<cmd>edit term://nu<CR>", { desc = "打开 Nushell" })
vim.keymap.set("n", "<leader>ef", "<cmd>edit term://fish<CR>", { desc = "打开 Fish" })
vim.keymap.set("n", "<leader>eb", "<cmd>edit term://bash<CR>", { desc = "打开 Bash" })

--->
---> 控制台内
--->

vim.keymap.set('t', '<C-h>', [[<C-\><C-n>:TmuxNavigateLeft<CR>]], opts)
vim.keymap.set('t', '<C-j>', [[<C-\><C-n>:TmuxNavigateDown<CR>]], opts)
vim.keymap.set('t', '<C-k>', [[<C-\><C-n>:TmuxNavigateUp<CR>]], opts)
vim.keymap.set('t', '<C-l>', [[<C-\><C-n>:TmuxNavigateRight<CR>]], opts)

--->
---> Command 模式: Bash style
--->

vim.keymap.set('c', '<C-a>', '<Home>', { noremap = true, desc = '移动到行首' })
vim.keymap.set('c', '<C-e>', '<End>', { noremap = true, desc = '移动到行尾' })
vim.keymap.set('c', '<C-b>', '<Left>', { noremap = true, desc = '向左移动一个字符' })
vim.keymap.set('c', '<C-f>', '<Right>', { noremap = true, desc = '向右移动一个字符' })
vim.keymap.set('c', '<M-b>', '<S-Left>', { noremap = true, desc = '向左移动一个单词' })
vim.keymap.set('c', '<M-f>', '<S-Right>', { noremap = true, desc = '向右移动一个单词' })

