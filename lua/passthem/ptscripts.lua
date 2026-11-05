local pt_scripts_group = vim.api.nvim_create_augroup("PassthemScriptsGroup", {
    clear = true,
})

-- 在 Markdown 中，允许使用 <C-CR> 切换任务状态
vim.api.nvim_create_autocmd("FileType", {
    group = pt_scripts_group,
    pattern = "markdown",
    callback = function()
        vim.keymap.set("n", "<C-CR>", function()
            local line = vim.api.nvim_get_current_line()

            local indent, symbol, rest = line:match("^(%s*)- %[(.)%] (.*)")
            if indent then
                if symbol == " " then
                    symbol = "-"
                elseif symbol == "-" then
                    symbol = "x"
                elseif symbol == "x" then
                    symbol = " "
                end

                local new_line = indent .. "- [" .. symbol .. "] " .. rest
                vim.api.nvim_set_current_line(new_line)
                return
            end

            indent, rest = line:match("^(%s*)- (.*)")
            if indent then
                local new_line = indent .. "- [ ] " .. rest
                vim.api.nvim_set_current_line(new_line)
            end
        end)
    end
})

-- filetype 与 Markdown 代码围栏语言名不一致的映射；其余直接使用 filetype
local ft_to_lang = {
    javascriptreact = "jsx",
    typescriptreact = "tsx",
    sh = "bash",
    cs = "csharp",
    ps1 = "powershell",
    dosbatch = "bat",
    help = "vim",
}

-- 将可视选区包装成带 filename / line / 语言的 Markdown 代码块后复制。
-- 默认写入系统剪贴板 "+"；也可以带寄存器前缀，例如 "a<leader>cy。
local function copy_code_block()
    local sel_type = vim.fn.mode()
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")
    local lines = vim.fn.getregion(start_pos, end_pos, { type = sel_type })

    if #lines == 0 or (#lines == 1 and lines[1] == "") then
        return
    end

    local first = math.min(start_pos[2], end_pos[2])
    local last = math.max(start_pos[2], end_pos[2])
    local line_attr = first == last and tostring(first) or (first .. "-" .. last)

    local lang = ft_to_lang[vim.bo.filetype] or vim.bo.filetype
    local attrs = {}
    attrs[#attrs + 1] = lang ~= "" and lang or "text"

    local name = vim.api.nvim_buf_get_name(0)
    if name ~= "" then
        local rel = vim.fn.fnamemodify(name, ":p:.")
        attrs[#attrs + 1] = ('filename="%s"'):format((rel:gsub('"', "'")))
    end
    attrs[#attrs + 1] = ('line="%s"'):format(line_attr)

    local block = ("```%s\n%s\n```\n"):format(table.concat(attrs, " "), table.concat(lines, "\n"))

    local reg = vim.v.register
    if reg == "" or reg == '"' then
        reg = "+"
    end

    local ok = vim.fn.setreg(reg, block, "v") == 0
    vim.cmd("normal! \27") -- 退出 Visual 模式，和普通 y 的行为一致
    if ok then
        vim.notify(("已复制 %d 行到 %s"):format(#lines, reg), vim.log.levels.INFO)
    else
        vim.notify("复制失败：无法写入寄存器 " .. reg, vim.log.levels.ERROR)
    end
end

vim.keymap.set("x", "<leader>cy", copy_code_block, { desc = "复制为带文件名和行号的代码块" })
