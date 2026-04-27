-- 可以使用 `:source %` 重载这个文件

vim.opt.clipboard = "unnamedplus"

-- 见 `:help clipboard-osc52`
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  -- paste = {
  --   ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
  --   ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  -- },
}

-- 支持鼠标操作
vim.opt.mouse = "a"


--->
---> 行号
--->

vim.opt.nu = true
vim.opt.relativenumber = true

--->
---> 缩进与换行
--->

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false


--->
---> 文件管理
--->

vim.opt.swapfile = false
vim.opt.backup = false

-- 当重启 Vim 时，可以重做之前的东西
vim.opt.undofile = true

-- 禁用自带的文件管理器的头部 banner
vim.cmd("let g:netrw_banner = 0")


--->
---> Vim 搜索设置
--->

-- 在搜索时，搜索中途就跳转过去
vim.opt.incsearch = true

-- 如果在替换时内容在屏幕外，则会分屏展示结果
vim.opt.inccommand = "split"

vim.opt.ignorecase = true

-- 当搜索内容时，除非搜索词含有大写，不然都匹配小写
vim.opt.smartcase = true

vim.opt.hlsearch = true


--->
---> 视觉
--->

-- 使用 24 位真彩色
vim.opt.termguicolors = true

vim.opt.background = "dark"

-- 滚动时预留行数
vim.opt.scrolloff = 10

-- 给行号一列多余的空间
vim.opt.signcolumn = "yes:1"

-- 对于不同的模式，光标更改成不同的模式
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
-- vim.opt.guicursor = ""

-- 指令栏占用的高度
vim.opt.cmdheight = 0
-- vim.opt.cmdheight = 1

-- 在第 80 列显示一个墙，表示该行过长
-- vim.opt.colorcolumn = "80"
vim.opt.colorcolumn = ""

-- 标注光标所在行
vim.opt.cursorline = false


--->
---> 文件编辑
--->

vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.splitright = true -- 向右分屏而非向左
vim.opt.splitbelow = true -- 向下分屏而非向上

-- 当停止打字时，等待多久 (ms) 提交 CursorHold 时间并交换文件写入硬盘
-- 这和很多 LSP 插件响应速度有关
vim.opt.updatetime = 50

-- 将 @ 符号考虑到「合法文件名」内。这在一些 NodeJS 包裹中有用
vim.opt.isfname:append("@-@")

-- 如果项目中包含 .editorconfig，则让 vim 遵守它
vim.g.editorconfig = true


--->
---> 注册额外的语言
--->

vim.filetype.add({
	extension = {
		mdx = 'mdx'
	}
})
