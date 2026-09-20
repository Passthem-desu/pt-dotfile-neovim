local pt_scripts_group = vim.api.nvim_create_augroup("PassthemScriptsGroup", {
    clear=true,
})

-- 在 Markdown 中，允许使用 <C-CR> 切换任务状态
vim.api.nvim_create_autocmd("FileType", {
    group = pt_scripts_group,
    pattern = "markdown",
    callback = function ()
        vim.keymap.set("n", "<C-CR>", function ()
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
