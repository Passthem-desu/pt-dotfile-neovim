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
-- vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("v", "p", '"_dP', opts)
-- vim.keymap.set("v", "<C-c>", "y", opts)
-- vim.keymap.set("n", "<C-v>", "p", opts)
-- vim.keymap.set("v", "<C-v>", '"_dP', opts)
-- vim.keymap.set("i", "<C-v>", "<C-r>+", opts)

-- 在删除时，如果使用 <leader>d，则不会把删除内容放在剪切板
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

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
---> 标签页与分屏
--->

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "新建标签页" })
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<CR>", { desc = "关闭标签页" })
vim.keymap.set("n", "<leader>tt", "<cmd>tab split<CR>", { desc = "复制当前标签页" })

vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "关闭当前缓冲区" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufferlineCloseOthers", { desc = "关闭其他缓冲区" })

vim.keymap.set("n", "]t", "<cmd>tabn<CR>", { desc = "下一标签页" })
vim.keymap.set("n", "[t", "<cmd>tabp<CR>", { desc = "上一标签页" })

vim.keymap.set("n", "H", "<cmd>BufferlineCyclePrev<CR>", { desc = "上一缓冲区" })
vim.keymap.set("n", "L", "<cmd>BufferlineCycleNext<CR>", { desc = "下一缓冲区" })

vim.keymap.set("n", "[b", "<cmd>BufferlineCyclePrev<CR>", { desc = "上一缓冲区" })
vim.keymap.set("n", "]b", "<cmd>BufferlineCycleNext<CR>", { desc = "下一缓冲区" })

vim.keymap.set("n", "<leader>w%", "<C-w>v", { desc = "竖直分屏" })
vim.keymap.set("n", '<leader>w"', "<C-w>s", { desc = "水平分屏" })
vim.keymap.set("n", "<leader>wd", "<cmd>close<CR>", { desc = "关闭当前分屏" })

vim.keymap.set("n", "<C-_>", "<C-w>s<cmd>edit term://fish<CR>a", { desc = "打开一个控制台" })

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
---> AI 相关
--->

vim.keymap.set("n", "<leader>ai", function()
    require("codecompanion").toggle({
        window_opts = { layout = "vertical", width = 0.4 },
    })
end, { desc = "切换 CodeCompanion 窗口" })

--->
---> 文件管理
--->

vim.keymap.set("n", "<leader>en", "<cmd>edit term://nu<CR>", { desc = "打开 Nushell" })
vim.keymap.set("n", "<leader>ef", "<cmd>edit term://fish<CR>", { desc = "打开 Fish" })
vim.keymap.set("n", "<leader>eb", "<cmd>edit term://bash<CR>", { desc = "打开 Bash" })
